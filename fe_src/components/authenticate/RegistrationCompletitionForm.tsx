/* eslint-disable max-len */
import { useEffect, useState } from 'react';
import {
  Alert,
  Button,
  Container,
  Form,
} from 'react-bootstrap';
import { useHistory } from 'react-router';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/userSliceTypes';
import {
  updateProfile,
  userEmailStatus,
  userLoginStatus,
  userTaxNumber,
} from '../../store/userSlice';
import EmailAddress from '../form-components/EmailAddress';
import Password from '../form-components/Password';
import { testEmailAddress, testPassword } from '../utils/helpers';
import Loading from '../utils/Loading';

const RegistrationCompletitionForm = () => {
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
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus, history, loginStatus]);
  // End of redirections

  const taxNumber = useAppSelector(userTaxNumber);
  const [isFormValidated, setIsFormValidated] = useState(false);
  const [emailAddress, setEmailAddress] = useState('till.zoltan90@gmail.com');
  const [emailAddressRepeat, setEmailAddressRepeat] = useState('till.zoltan90@gmail.com');
  const [emailAddressError, setEmailAddressError] = useState('');
  const [newLoginPassword, setNewLoginPassword] = useState('Password1');
  const [newLoginPasswordRepeat, setNewLoginPasswordRepeat] = useState('Password1');
  const [newLoginPasswordError, setNewLoginPasswordError] = useState('');
  const [registrationError, setRegistrationError] = useState('');

  const onRegistrationCompletitionAttempt = (e: React.MouseEvent) => {
    e.preventDefault();
    let canSubmit = true;
    setIsFormValidated(false);
    setEmailAddressError('');
    setNewLoginPasswordError('');
    setRegistrationError('');

    if (!emailAddress || !emailAddressRepeat) {
      setEmailAddressError('Hiba: Az email cím megadása kötelező!');
      canSubmit = false;
    } else if (!testEmailAddress(emailAddress) || !testEmailAddress(emailAddressRepeat)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
      canSubmit = false;
    } else if (emailAddress !== emailAddressRepeat) {
      setEmailAddressError('Hiba: A két email cím mező értéke eltérő!');
      canSubmit = false;
    }

    if (!newLoginPassword || !newLoginPasswordRepeat) {
      setNewLoginPasswordError('Hiba: A jelszó megadása kötelező!');
      canSubmit = false;
    } else if (!testPassword(newLoginPassword) || !testPassword(newLoginPasswordRepeat)) {
      setNewLoginPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
      canSubmit = false;
    } else if (newLoginPassword !== newLoginPasswordRepeat) {
      setNewLoginPasswordError('Hiba: A két jelszó mező értéke eltérő!');
      canSubmit = false;
    }

    if (canSubmit) {
      setIsFormValidated(true);
      setIsComponentLoading(true);
      dispatch(updateProfile({
        taxNumber,
        email: emailAddress,
        ownEmail: true,
        password: newLoginPassword,
      }))
        .then(() => history.push('/validate-email'))
        .catch((err) => {
          setIsComponentLoading(false);
          setIsFormValidated(false);
          setRegistrationError(err.message);
        });
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
    <>
      <Container>
        <p className="mt-5">
          A dokumentumkezelő használatának megkezdéséhez szükséges egy érvényes email cím (melyen szükség esetén fel tudjuk venni Önnel a kapcsolatot), illetve egy Ön által választott jelszó megadása. Ezekre a lenti űrlapon van lehetőség. Az elgépelések kiküszöbölésének érdekében kérjük, hogy mindkét adatot kétszer adja meg.
        </p>
      </Container>
      <Container className="form-container" fluid="md">
        <Form noValidate validated={isFormValidated}>
          <EmailAddress
            emailAddress={emailAddress}
            setEmailAddress={setEmailAddress}
            feedback={false}
            emailAddressError={emailAddressError}
          />
          <EmailAddress
            label="Email cím újra"
            emailAddress={emailAddressRepeat}
            setEmailAddress={setEmailAddressRepeat}
            feedback
            emailAddressError={emailAddressError}
          />
          <Password
            password={newLoginPassword}
            setPassword={setNewLoginPassword}
            showRequirements
            requireValidation
            passwordError={newLoginPasswordError}
          />
          <Password
            label="Jelszó újra"
            password={newLoginPasswordRepeat}
            setPassword={setNewLoginPasswordRepeat}
            showRequirements={false}
            requireValidation
            negativeFeedback
            passwordError={newLoginPasswordError}
          />
          <Button onClick={onRegistrationCompletitionAttempt} variant="primary">
            Regisztráció véglegesítése
          </Button>
        </Form>
        {registrationError && (
          <Alert variant="danger">{registrationError}</Alert>
        )}
      </Container>
    </>
  );
};

export default RegistrationCompletitionForm;
