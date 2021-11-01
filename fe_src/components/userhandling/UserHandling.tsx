import { useEffect, useState } from 'react';
import { Container, Form } from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppSelector } from '../../store/hooks';
import { selectSelectedUser } from '../../store/otherUsersSlice';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/userSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/userSlice';
import CompanyName from '../form-components/CompanyName';
import TaxNumber from '../form-components/TaxNumber';
import UserRealName from '../form-components/UserRealName';
import Loading from '../utils/Loading';

import UserSearch from './UserSearch';

const UserHandling = () => {
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
  const [companyName, setCompanyName] = useState('');
  const [taxNumber, setTaxNumber] = useState('');
  const [userRealName, setUserRealName] = useState('');

  useEffect(() => {
    if (selectedUser) {
      setCompanyName(selectedUser.companyName);
      setTaxNumber(String(selectedUser.taxNumber));
      setUserRealName(selectedUser.userRealName);
    }
  }, [selectedUser]);

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
            taxNumber={taxNumber}
            feedback={false}
          />
          <UserRealName
            disabled={false}
            userRealName={userRealName}
            setUserRealName={setUserRealName}
          />
          <CompanyName
            disabled={false}
            companyName={companyName}
            setCompanyName={setCompanyName}
          />
        </Form>
      </Container>
      )}
    </Container>
  );
};

export default UserHandling;
