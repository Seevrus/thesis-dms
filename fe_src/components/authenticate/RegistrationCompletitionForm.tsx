/* eslint-disable max-len */
import * as React from 'react';
import {
  Alert,
  Button,
  Container,
  Form,
} from 'react-bootstrap';
import { useHistory } from 'react-router';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum } from '../../store/userSliceTypes';
import { updateProfile, userEmailStatus, userTaxNumber } from '../../store/userSlice';
import { emailRegex, passwordRegex } from '../utils/helpers';

const { useEffect, useState } = React;

const RegistrationCompletitionForm = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  useEffect(() => {
    if (!emailStatus) {
      history.push('/login');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus]);
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

  const testEmailAddress = (address: string) => emailRegex.test(address);

  // Minimum eight characters, at least one uppercase letter,
  // one lowercase letter and one number:
  const testNewLoginPassword = (password: string) => passwordRegex.test(password);

  const onEmailAddressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmailAddress(e.target.value);
    if (!testEmailAddress(e.target.value)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
    } else {
      setEmailAddressError('');
    }
  };

  const onEmailAddressRepeatChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmailAddressRepeat(e.target.value);
    if (!testEmailAddress(e.target.value)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
    } else {
      setEmailAddressError('');
    }
  };

  const onNewLoginPasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setNewLoginPassword(e.target.value);
    if (!testNewLoginPassword(e.target.value)) {
      setNewLoginPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
    } else {
      setNewLoginPasswordError('');
    }
  };

  const onNewLoginPasswordRepeatChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setNewLoginPasswordRepeat(e.target.value);
    if (!testNewLoginPassword(e.target.value)) {
      setNewLoginPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
    } else {
      setNewLoginPasswordError('');
    }
  };

  const onRegistrationCompletitionAttempt = (e: React.MouseEvent) => {
    e.preventDefault();
    setIsFormValidated(false);
    setEmailAddressError('');
    setNewLoginPasswordError('');
    setRegistrationError('');

    if (!emailAddress || !emailAddressRepeat) {
      setEmailAddressError('Hiba: Az email cím megadása kötelező!');
      return false;
    }
    if (!testEmailAddress(emailAddress) || !testEmailAddress(emailAddressRepeat)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
      return false;
    }
    if (emailAddress !== emailAddressRepeat) {
      setEmailAddressError('Hiba: A két email cím mező értéke eltérő!');
      return false;
    }

    if (!newLoginPassword || !newLoginPasswordRepeat) {
      setNewLoginPasswordError('Hiba: A jelszó megadása kötelező!');
      return false;
    }
    if (!testNewLoginPassword(newLoginPassword) || !testNewLoginPassword(newLoginPasswordRepeat)) {
      setNewLoginPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
      return false;
    }
    if (newLoginPassword !== newLoginPasswordRepeat) {
      setNewLoginPasswordError('Hiba: A két jelszó mező értéke eltérő!');
      return false;
    }

    setEmailAddressError('');
    setIsFormValidated(true);
    dispatch(updateProfile({
      taxNumber,
      email: emailAddress,
      ownEmail: true,
      password: newLoginPassword,
    }))
      .then(() => history.push('/validate-email'))
      .catch((err) => {
        setIsFormValidated(false);
        setRegistrationError(err.message);
      });

    return true;
  };

  return (
    <>
      <Container>
        <p className="mt-5">
          A dokumentumkezelő használatának megkezdéséhez szükséges egy érvényes email cím (melyen szükség esetén fel tudjuk venni Önnel a kapcsolatot), illetve egy Ön által választott jelszó megadása. Ezekre a lenti űrlapon van lehetőség. Az elgépelések kiküszöbölésének érdekében kérjük, hogy mindkét adatot kétszer adja meg.
        </p>
      </Container>
      <Container className="form-container" fluid="md">
        <Form noValidate validated={isFormValidated}>
          <Form.Group className="mb-3" controlId="emailAddress">
            <Form.Label>Email cím</Form.Label>
            <Form.Control
              isInvalid={!!emailAddressError}
              onInput={onEmailAddressChange}
              required
              value={emailAddress}
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="emailAddressRepeat">
            <Form.Label>Email cím újra</Form.Label>
            <Form.Control
              isInvalid={!!emailAddressError}
              onInput={onEmailAddressRepeatChange}
              required
              value={emailAddressRepeat}
            />
            <Form.Control.Feedback type="invalid">{emailAddressError}</Form.Control.Feedback>
          </Form.Group>
          <Form.Group className="mb-3" controlId="newLoginPassword">
            <Form.Label>
              Jelszó
              <ul>
                <li>Minimum 8 karakter</li>
                <li>Minimum 1 kisbetű</li>
                <li>Minimum 1 nagybetű</li>
                <li>Minimum 1 számjegy</li>
              </ul>
            </Form.Label>
            <Form.Control
              isInvalid={!!newLoginPasswordError}
              onInput={onNewLoginPasswordChange}
              required
              type="password"
              value={newLoginPassword}
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="newLoginPasswordRepeat">
            <Form.Label>Jelszó újra</Form.Label>
            <Form.Control
              isInvalid={!!newLoginPasswordError}
              onInput={onNewLoginPasswordRepeatChange}
              required
              type="password"
              value={newLoginPasswordRepeat}
            />
            <Form.Control.Feedback type="invalid">{newLoginPasswordError}</Form.Control.Feedback>
          </Form.Group>
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
