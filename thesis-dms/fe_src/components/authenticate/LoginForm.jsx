import React, { useEffect, useState } from 'react';
import {
  Alert,
  Button,
  Container,
  Form,
} from 'react-bootstrap';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router';
import { EMAIL_STATUS, login, userEmailStatus } from '../../store/usersSlice';

const LoginForm = () => {
  const dispatch = useDispatch();
  const history = useHistory();

  // Redirect user is they are not supposed to be here
  const emailStatus = useSelector(userEmailStatus);
  useEffect(() => {
    if (emailStatus === EMAIL_STATUS.NO_EMAIL) {
      history.push('/complete-registration');
    }
    else if (emailStatus === EMAIL_STATUS.NOT_VALIDATED) {
      history.push('/email-validation');
    }
  }, [emailStatus]);
  // End of redirections

  const [isFormValidated, setIsFormValidated] = useState(false);
  const [taxNumber, setTaxNumber] = useState('1315760217');
  const [loginPassword, setLoginPassword] = useState('Password1');
  const [taxNumberError, setTaxNumberError] = useState('');
  const [loginError, setLoginError] = useState('');

  const onTaxNumberChange = (e) => {
    const taxNumberInput = e.target.value;
    // Only numbers:
    const re = /^[0-9\b]+$/;

    if (taxNumberInput === '' || (re.test(taxNumberInput) && taxNumberInput < 1e10)) {
      setTaxNumber(taxNumberInput);
    }
  };

  const onLoginPasswordChange = (e) => {
    const loginPwdInput = e.target.value;
    // Only letters and numbers:
    const re = /^[A-Za-z0-9áéíóőúűÁÉÍÓŐŰ]*$/;

    if (loginPwdInput === '' || re.test(loginPwdInput)) {
      setLoginPassword(loginPwdInput);
    }
  };

  const onLoginAttempt = async (e) => {
    e.preventDefault();
    setIsFormValidated(false);
    setLoginError('');

    if (taxNumber < 1e9 || taxNumber > 1e10) {
      setTaxNumberError('Hiba: Az adóazonosító jel 10 számjegyből állhat!');
      return false;
    }

    setTaxNumberError('');
    setIsFormValidated(true);
    dispatch(login({ taxNumber, loginPwd: loginPassword }))
      // eslint-disable-next-line no-shadow
      .then(({ payload: { emailStatus, message, outcome } }) => {
        if (outcome === 'failure') {
          setIsFormValidated(false);
          setLoginError(message);
        } else if (emailStatus === EMAIL_STATUS.NO_EMAIL) {
          history.push('/complete-registration');
        }
      });

    return true;
  };

  return (
    <Container className="form-container" fluid="md">
      <Form noValidate validated={isFormValidated}>
        <Form.Group className="mb-3" controlId="taxNumber">
          <Form.Label>Adóazonosító jel</Form.Label>
          <Form.Control
            isInvalid={!!taxNumberError}
            onChange={onTaxNumberChange}
            required
            value={taxNumber}
          />
          <Form.Control.Feedback type="invalid">{taxNumberError}</Form.Control.Feedback>
        </Form.Group>
        <Form.Group className="mb-3" controlId="loginPassword">
          <Form.Label>Jelszó</Form.Label>
          <Form.Control onChange={onLoginPasswordChange} required type="password" value={loginPassword} />
        </Form.Group>
        <Button onClick={onLoginAttempt} variant="primary">
          Belépés
        </Button>
        <Button disabled variant="secondary">
          Elfelejtettem a jelszavam
        </Button>
      </Form>
      {loginError && (
        <Alert variant="danger">{loginError}</Alert>
      )}
    </Container>
  );
};

export default LoginForm;
