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
import { EMAIL_STATUS, userEmailStatus, validateEmailAddress } from '../../store/usersSlice';

const EmailValidationForm = () => {
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
  const [emailCode, setEmailCode] = useState('');
  const [emailCodeError, setEmailCodeError] = useState('');
  const [validationError, setValidationError] = useState('');

  const testEmailCode = (code) => {
    const codeRegex = /^\d{6}$/;
    return codeRegex.test(code);
  };

  const onEmailCodeChange = (e) => {
    setEmailCode(e.target.value);
    if (!testEmailCode(e.target.value)) {
      setEmailCodeError('Hiba: A kód formátuma nem megfelelő!');
    } else {
      setEmailCodeError('');
    }
  };

  const onEmailValidationAttempt = (e) => {
    e.preventDefault();
    setIsFormValidated(false);
    setEmailCodeError('');
    setValidationError('');

    if (!emailCode) {
      setEmailCodeError('Hiba: A kód megadása kötelező!');
      return false;
    }
    if (!testEmailCode(emailCode)) {
      setEmailCodeError('Hiba: A kód formátuma nem megfelelő!');
      return false;
    }

    setEmailCodeError('');
    setIsFormValidated(true);
    dispatch(validateEmailAddress({ emailCode }))
      // eslint-disable-next-line no-shadow
      .then(({ payload: { emailStatus, outcome, message } }) => {
        if (outcome === 'failure') {
          setIsFormValidated(false);
          setValidationError(message);
        } else if (emailStatus === EMAIL_STATUS.VALID_EMAIL) {
          // TODO
        }
      });

    return true;
  };

  return (
    <>
      <Container>
        <p className="mt-5">
          Email cím regisztrációjának befejezéséhez kérem adja meg a korábban megadott email címére kiküldött ellenőrző kódot az erre szolgáló mezőben. Ezt követően már hozzá for férni a dokumentumkezelő rendszerhez. Amennyiben nem találja a kiküldött üzenetet, kérem, ellenőrizze le a Spam/Levélszemét mappát is.
        </p>
      </Container>
      <Container className="form-container" fluid="md">
        <Form noValidate validated={isFormValidated}>
          <Form.Group className="mb-3" controlId="emailCode">
            <Form.Label>Email kód</Form.Label>
            <Form.Control
              isInvalid={!!emailCodeError}
              onInput={onEmailCodeChange}
              required
              value={emailCode}
            />
            <Form.Control.Feedback type="invalid">{emailCodeError}</Form.Control.Feedback>
          </Form.Group>
          <Button onClick={onEmailValidationAttempt} variant="primary">
            Email cím validálása
          </Button>
        </Form>
        {validationError && (
          <Alert variant="danger">{validationError}</Alert>
        )}
      </Container>
    </>
  );
};

export default EmailValidationForm;
