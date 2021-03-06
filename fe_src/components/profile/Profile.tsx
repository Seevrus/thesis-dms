import { useEffect, useState } from 'react';
import { Container, Form } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/user/userSliceTypes';
import {
  companyName,
  updateProfile,
  userEmail,
  userEmailStatus,
  userLoginStatus,
  userRealName,
  userTaxNumber,
} from '../../store/user/userSlice';
import CompanyName from '../form-components/CompanyName';
import EmailAddress from '../form-components/EmailAddress';
import Password from '../form-components/Password';
import TaxNumber from '../form-components/TaxNumber';
import UserRealName from '../form-components/UserRealName';
import { testEmailAddress, testPassword } from '../utils/helpers';
import Loading from '../utils/Loading';

const Profile = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  useEffect(() => {
    document.title = 'Profilom';
  }, []);

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
      navigate('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      navigate('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      navigate('/validate-email');
    }
  }, [emailStatus, navigate, loginStatus]);
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
      setEmailAddressError('Hiba: Az ??j email c??m nem egyezhet meg az el??z??vel!');
    } else if (!testEmailAddress(emailAddress)) {
      setEmailAddressError('Hiba: Az email c??m form??tuma nem megfelel??!');
    } else {
      setEmailAddressError('');
      setIsComponentLoading(true);
      dispatch(updateProfile({
        taxNumber: originalTaxNumber,
        userEmail: emailAddress,
        ownEmail: true,
      }))
        .then(() => navigate('/validate-email'))
        .catch((err) => {
          setIsComponentLoading(false);
          setEmailAddressError(err.message);
        });
    }
  };

  const setNewPassword = () => {
    if (password !== passwordRepeat) {
      setPasswordError('Hiba: A k??t jelsz?? mez?? ??rt??ke elt??r??!');
    } else if (!testPassword(password)) {
      setPasswordError('Hiba: A jelsz?? form??tuma nem megfelel??!');
    } else {
      setPasswordError('');
      setIsComponentLoading(true);
      dispatch(updateProfile({
        taxNumber: originalTaxNumber,
        password,
      }))
        .then(() => {
          setPasswordError('');
          setPasswordSuccess('Jelsz?? m??dos??t??sa sikeres.');
        })
        .catch((err) => {
          setPasswordError(err.message);
          setPasswordSuccess('');
        })
        .finally(() => setIsComponentLoading(false));
    }
  };

  if (isComponentLoading) {
    return <Loading />;
  }

  return (
    <Container className="form-container">
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
          label="??j jelsz??"
          password={password}
          setPassword={setPassword}
          showRequirements
          requireValidation
          passwordError={passwordError}
          passwordSuccess={passwordSuccess}
        />
        <Password
          label="??j jelsz?? ??jra"
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
