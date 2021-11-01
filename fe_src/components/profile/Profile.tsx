import { useEffect, useState } from 'react';
import { Container, Form } from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/userSliceTypes';
import {
  companyName,
  updateProfile,
  userEmail,
  userEmailStatus,
  userLoginStatus,
  userRealName,
  userTaxNumber,
} from '../../store/userSlice';
import CompanyName from '../form-components/CompanyName';
import EmailAddress from '../form-components/EmailAddress';
import Password from '../form-components/Password';
import TaxNumber from '../form-components/TaxNumber';
import UserRealName from '../form-components/UserRealName';
import { testEmailAddress, testPassword } from '../utils/helpers';
import Loading from '../utils/Loading';

const Profile = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  const loginStatus = useAppSelector(userLoginStatus);

  useEffect(() => {
    if (!loginStatus) {
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

  // State of the form
  const originalCompanyName = useAppSelector(companyName);
  const originalEmailAddress = useAppSelector(userEmail);
  const originalTaxNumber = useAppSelector(userTaxNumber);
  const originalUserRealName = useAppSelector(userRealName);
  const [emailAddress, setEmailAddress] = useState('');
  const [emailAddressError, setEmailAddressError] = useState('');
  const [password, setPassword] = useState('');
  const [passwordRepeat, setPasswordRepeat] = useState('');
  const [passwordError, setPasswordError] = useState('');
  const [passwordSuccess, setPasswordSuccess] = useState('');

  useEffect(() => {
    setEmailAddress(originalEmailAddress);
  }, [originalEmailAddress]);
  // End of state of the form

  const setNewEmailAddress = () => {
    if (emailAddress === originalEmailAddress) {
      setEmailAddressError('Hiba: Az új email cím nem egyezhet meg az előzővel!');
    } else if (!testEmailAddress(emailAddress)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
    } else {
      setEmailAddressError('');
      setIsComponentLoading(true);
      dispatch(updateProfile({
        taxNumber: originalTaxNumber,
        email: emailAddress,
        ownEmail: true,
      }))
        .then(() => history.push('/validate-email'))
        .catch((err) => {
          setIsComponentLoading(false);
          setEmailAddressError(err.message);
        });
    }
  };

  const setNewPassword = () => {
    if (password !== passwordRepeat) {
      setPasswordError('Hiba: A két jelszó mező értéke eltérő!');
    } else if (!testPassword(password)) {
      setPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
    } else {
      setPasswordError('');
      setIsComponentLoading(true);
      dispatch(updateProfile({
        taxNumber: originalTaxNumber,
        password,
      }))
        .then(() => {
          setPasswordError('');
          setPasswordSuccess('Jelszó módosítása sikeres.');
        })
        .catch((err) => {
          setPasswordError(err.message);
          setPasswordSuccess('');
        })
        .finally(() => setIsComponentLoading(false));
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
    <Container className="form-container">
      <h3 className="page-title text-center">Profilom</h3>
      <Form>
        <TaxNumber
          disabled
          taxNumber={originalTaxNumber}
          feedback={false}
        />
        <UserRealName userRealName={originalUserRealName} />
        <CompanyName companyName={originalCompanyName} />
        <EmailAddress
          emailAddress={emailAddress}
          setEmailAddress={setEmailAddress}
          feedback
          emailAddressError={emailAddressError}
          updatable
          updateEmailAddress={setNewEmailAddress}
        />
        <Password
          label="Új jelszó"
          password={password}
          setPassword={setPassword}
          showRequirements
          requireValidation
          passwordError={passwordError}
          passwordSuccess={passwordSuccess}
        />
        <Password
          label="Új jelszó újra"
          password={passwordRepeat}
          setPassword={setPasswordRepeat}
          showRequirements={false}
          requireValidation
          negativeFeedback
          passwordError={passwordError}
          positiveFeedback
          passwordSuccess={passwordSuccess}
          updatable
          updatePassword={setNewPassword}
        />
      </Form>
    </Container>
  );
};

export default Profile;
