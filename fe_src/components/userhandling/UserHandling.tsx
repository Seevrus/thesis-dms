import {
  contains,
  equals,
  isNil,
  keys,
  reject,
} from 'ramda';
import { useEffect, useState } from 'react';
import {
  Alert,
  Button,
  Container,
  Form,
} from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import {
  searchUsers,
  selectSelectedUser,
  setUser,
  updateUser,
} from '../../store/otherUsersSlice';
import {
  EmailStatusEnum,
  LoginStatusEnum,
  UpdateProfileRequestT,
  UserPermissionsEnum,
  UserStatusEnum,
} from '../../store/userSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/userSlice';
import Attempts from '../form-components/Attempts';
import CompanyName from '../form-components/CompanyName';
import EmailAddress from '../form-components/EmailAddress';
import EmailStatus from '../form-components/EmailStatus';
import Password from '../form-components/Password';
import TaxNumber from '../form-components/TaxNumber';
import UserPermissions from '../form-components/UserPermissions';
import UserRealName from '../form-components/UserRealName';
import { testPassword } from '../utils/helpers';
import Loading from '../utils/Loading';

import UserSearch from './UserSearch';

const UserHandling = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  const loginStatus = useAppSelector(userLoginStatus);
  useEffect(() => {
    if (!emailStatus) {
      setIsComponentLoading(true);
    } else {
      setIsComponentLoading(false);
    }

    if (loginStatus === LoginStatusEnum.NOT_LOGGED_IN) {
      history.push('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus, history, loginStatus]);
  // End of redirections

  const selectedUser = useAppSelector(selectSelectedUser);
  const [companyNameST, setCompanyNameST] = useState('');
  const [emailAddressST, setEmailAddressST] = useState('');
  const [emailStatusST, setEmailStatusST] = useState<`${EmailStatusEnum}`>(null);
  const [passwordST, setPasswordST] = useState('');
  const [taxNumberST, setTaxNumberST] = useState('');
  const [unlockUserST, setUnlockUserST] = useState(false);
  const [userPermissionsST, setUserPermissionsST] = useState<`${UserPermissionsEnum}`[]>([]);
  const [userRealNameST, setUserRealNameST] = useState('');
  const [updateFeedback, setUpdateFeedback] = useState('');

  useEffect(() => {
    if (selectedUser) {
      setCompanyNameST(selectedUser.companyName);
      setEmailAddressST(selectedUser.userEmail);
      setEmailStatusST(selectedUser.emailStatus);
      setTaxNumberST(String(selectedUser.taxNumber));
      setUserRealNameST(selectedUser.userRealName);

      if (selectedUser.userStatus === UserStatusEnum.ACTIVE) {
        setUserPermissionsST(selectedUser.userPermissions);
      } else {
        setUserPermissionsST([selectedUser.userStatus]);
      }
    }
  }, [selectedUser]);

  const onUserUpdate = () => {
    const requestUserPermissions = contains(UserPermissionsEnum.INACTIVE, userPermissionsST)
      ? []
      : userPermissionsST;
    const requestUserStatus = contains(UserStatusEnum.INACTIVE, userPermissionsST)
      ? UserStatusEnum.INACTIVE
      : UserStatusEnum.ACTIVE;

    const requestData: UpdateProfileRequestT = reject(isNil, {
      taxNumber: selectedUser.taxNumber,
      userRealName: userRealNameST !== selectedUser.userRealName ? userRealNameST : undefined,
      companyName: companyNameST !== selectedUser.companyName ? companyNameST : undefined,
      userEmail: emailAddressST !== selectedUser.userEmail ? emailAddressST : undefined,
      ownEmail: emailAddressST !== selectedUser.userEmail ? false : undefined,
      userStatus: requestUserStatus !== selectedUser.userStatus ? requestUserStatus : undefined,
      emailStatus: emailStatusST !== selectedUser.emailStatus ? emailStatusST : undefined,
      password: testPassword(passwordST) ? passwordST : undefined,
      attempts: selectedUser.lockedOut && unlockUserST ? unlockUserST : undefined,
      userPermissions: !equals(requestUserPermissions, selectedUser.userPermissions)
        ? requestUserPermissions
        : undefined,
    });
    const isSomethingChanged = keys(requestData).length > 1;
    if (isSomethingChanged) {
      dispatch(updateUser(requestData))
        .then(() => {
          setUpdateFeedback('Módosítások mentése sikeres.');
          dispatch(searchUsers(''))
            .then(() => {
              dispatch(setUser(selectedUser.taxNumber));
            });
        })
        .catch((err) => setUpdateFeedback(err.message));
    }
  };

  if (isComponentLoading) {
    return (
      <Container className="mt-5 mb-5">
        <Loading />
      </Container>
    );
  }

  return (
    <Container className="mt-5 mb-5">
      <h3 className="page-title text-center">Felhasználók kezelése</h3>
      <UserSearch />
      {selectedUser
      && (
      <Container className="form-container">
        <Form>
          <TaxNumber
            disabled
            taxNumber={taxNumberST}
            feedback={false}
          />
          <UserRealName
            disabled={false}
            userRealName={userRealNameST}
            setUserRealName={setUserRealNameST}
          />
          <CompanyName
            disabled={false}
            companyName={companyNameST}
            setCompanyName={setCompanyNameST}
          />
          <EmailStatus
            emailStatusST={emailStatusST}
            setEmailStatusST={setEmailStatusST}
          />
          <EmailAddress
            emailAddress={emailAddressST}
            setEmailAddress={setEmailAddressST}
          />
          <Password
            label="Új jelszó"
            password={passwordST}
            setPassword={setPasswordST}
            showRequirements
            requireValidation={false}
          />
          <UserPermissions
            userPermissionsST={userPermissionsST}
            setUserPermissionsST={setUserPermissionsST}
          />
          <Attempts
            lockedOut={selectedUser.lockedOut}
            unlockUserST={unlockUserST}
            setUnlockUserST={setUnlockUserST}
          />
          <Button onClick={onUserUpdate} variant="primary">
            Mentés
          </Button>
        </Form>
        {updateFeedback && (
        <Alert className="alert-warning" variant="warning">
          {updateFeedback}
        </Alert>
        )}
      </Container>
      )}
    </Container>
  );
};

export default UserHandling;
