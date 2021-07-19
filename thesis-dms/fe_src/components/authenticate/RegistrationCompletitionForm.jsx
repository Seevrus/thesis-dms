/* eslint-disable max-len */
import React, { useEffect, useState } from 'react';
import {
  Alert,
  Button,
  Container,
  Form,
} from 'react-bootstrap';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router';
import { EMAIL_STATUS, completeRegistration, userEmailStatus } from '../../store/usersSlice';

const RegistrationCompletitionForm = () => {
  const dispatch = useDispatch();
  const history = useHistory();

  // Redirect user is they are not supposed to be here
  const emailStatus = useSelector(userEmailStatus);
  useEffect(() => {
    if (!emailStatus) {
      history.push('/login');
    } else if (emailStatus === EMAIL_STATUS.NO_EMAIL) {
      history.push('/complete-registration');
    }
  }, [emailStatus]);
  // End of redirections

  const [isFormValidated, setIsFormValidated] = useState(false);
  const [emailAddress, setEmailAddress] = useState('till.zoltan90@gmail.com');
  const [emailAddressRepeat, setEmailAddressRepeat] = useState('till.zoltan90@gmail.com');
  const [emailAddressError, setEmailAddressError] = useState('');
  const [newLoginPassword, setNewLoginPassword] = useState('Password1');
  const [newLoginPasswordRepeat, setNewLoginPasswordRepeat] = useState('Password1');
  const [newLoginPasswordError, setNewLoginPasswordError] = useState('');
  const [registrationError, setRegistrationError] = useState('');

  const testEmailAddress = (address) => {
    const emailRegex = /^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[A-Za-z]+$/;
    return emailRegex.test(address);
  };

  const testNewLoginPassword = (password) => {
    // Minimum eight characters, at least one uppercase letter,
    // one lowercase letter and one number:
    const passwordRegex = /^(?=.*[a-záéíóőúű])(?=.*[A-ZÁÉÍÓŐÚŰ])(?=.*\d)[a-záéíóőúűA-ZÁÉÍÓŐÚŰ\d]{8,}$/;
    return passwordRegex.test(password);
  };

  const onEmailAddressChange = (e) => {
    setEmailAddress(e.target.value);
    if (!testEmailAddress(e.target.value)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
    } else {
      setEmailAddressError('');
    }
  };

  const onEmailAddressRepeatChange = (e) => {
    setEmailAddressRepeat(e.target.value);
    if (!testEmailAddress(e.target.value)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
    } else {
      setEmailAddressError('');
    }
  };

  const onNewLoginPasswordChange = (e) => {
    setNewLoginPassword(e.target.value);
    if (!testNewLoginPassword(e.target.value)) {
      setNewLoginPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
    } else {
      setNewLoginPasswordError('');
    }
  };

  const onNewLoginPasswordRepeatChange = (e) => {
    setNewLoginPasswordRepeat(e.target.value);
    if (!testNewLoginPassword(e.target.value)) {
      setNewLoginPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
    } else {
      setNewLoginPasswordError('');
    }
  };

  const onRegistrationCompletitionAttempt = (e) => {
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
    dispatch(completeRegistration({ email: emailAddress, password: newLoginPassword }))
      .then(({ payload: { emailStatus, outcome, message } }) => {
        if (outcome === 'failure') {
          setIsFormValidated(false);
          setRegistrationError(message);
        } else if (emailStatus === EMAIL_STATUS.NOT_VALIDATED) {
          // TODO
        }
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
