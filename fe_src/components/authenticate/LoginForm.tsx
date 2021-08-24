import * as React from 'react';
import {
  Alert,
  Button,
  Container,
  Form,
} from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum } from '../../store/usersSliceTypes';
import { login, userEmailStatus } from '../../store/usersSlice';

const { useEffect, useState } = React;

const LoginForm = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  useEffect(() => {
    if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    } else if (emailStatus === EmailStatusEnum.VALID_EMAIL) {
      history.push('/documents');
    }
  }, [emailStatus]);
  // End of redirections

  const [isFormValidated, setIsFormValidated] = useState(false);
  const [taxNumber, setTaxNumber] = useState('1315760217');
  const [loginPassword, setLoginPassword] = useState('Password1');
  const [taxNumberError, setTaxNumberError] = useState('');
  const [loginError, setLoginError] = useState('');

  const onTaxNumberChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const taxNumberInput = e.target.value;
    // Only numbers:
    const re = /^[0-9\b]+$/;

    if (taxNumberInput === '' || (re.test(taxNumberInput) && Number(taxNumberInput) < 1e10)) {
      setTaxNumber(taxNumberInput);
    }
  };

  const onLoginPasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const loginPwdInput = e.target.value;
    // Only letters and numbers:
    const re = /^[A-Za-z0-9áéíóőúűÁÉÍÓŐŰ]*$/;

    if (loginPwdInput === '' || re.test(loginPwdInput)) {
      setLoginPassword(loginPwdInput);
    }
  };

  const onLoginAttempt = async (e: React.MouseEvent) => {
    e.preventDefault();
    setIsFormValidated(false);
    setLoginError('');

    if (Number(taxNumber) < 1e9 || Number(taxNumber) > 1e10) {
      setTaxNumberError('Hiba: Az adóazonosító jel 10 számjegyből állhat!');
      return false;
    }

    setTaxNumberError('');
    setIsFormValidated(true);
    dispatch(login({ taxNumber, password: loginPassword }))
      .catch((err) => {
        setIsFormValidated(false);
        setLoginError(`Hiba: ${err.message}`);
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
