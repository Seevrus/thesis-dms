import * as React from 'react';
import {
  Button,
  Container,
  Form,
  InputGroup,
} from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum } from '../../store/usersSliceTypes';
import {
  companyName,
  updateProfile,
  userEmail,
  userEmailStatus,
  userRealName,
  userTaxNumber,
} from '../../store/usersSlice';
import { emailRegex, passwordRegex } from '../utils/helpers';

const { useEffect, useState } = React;

const Profile = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  useEffect(() => {
    if (!emailStatus) {
      history.push('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus]);
  // End of redirections

  const originalEmailAddress = useAppSelector(userEmail);
  const taxNumber = useAppSelector(userTaxNumber);
  const [emailAddress, setEmailAddress] = useState(originalEmailAddress);
  const [emailAddressError, setEmailAddressError] = useState('');
  const [password, setPassword] = useState('');
  const [passwordRepeat, setPasswordRepeat] = useState('');
  const [passwordError, setPasswordError] = useState('');
  const [passwordSuccess, setPasswordSuccess] = useState('');

  const onEmailChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const emailInput = e.target.value;
    setEmailAddress(emailInput);

    if (!emailRegex.test(emailInput)) {
      setEmailAddressError('Hiba: Az email cím formátuma nem megfelelő!');
    } else {
      setEmailAddressError('');
    }
  };

  const setNewEmailAddress = () => {
    if (emailAddress === originalEmailAddress) {
      setEmailAddressError('Hiba: Az új email cím nem egyezhet meg az előzővel!');
    } else {
      setEmailAddressError('');
      dispatch(updateProfile({
        taxNumber,
        email: emailAddress,
        ownEmail: true,
      }))
        .then(() => history.push('/validate-email'))
        .catch((err) => {
          setEmailAddressError(err.message);
        });
    }
  };

  const setNewPassword = () => {
    if (password !== passwordRepeat) {
      setPasswordError('Hiba: A két jelszó mező értéke eltérő!');
    } else if (!passwordRegex.test(password)) {
      setPasswordError('Hiba: A jelszó formátuma nem megfelelő!');
    } else {
      setPasswordError('');
      dispatch(updateProfile({
        taxNumber,
        password,
      }))
        .then(() => setPasswordSuccess('Jelszó módosítása sikeres.'))
        .catch((err) => {
          setPasswordError(err.message);
        });
    }
  };

  return (
    <Container className="form-container">
      <h3 className="page-title text-center">Profilom</h3>
      <Form>
        <Form.Group className="mb-3" controlId="taxNumber">
          <Form.Label>Adóazonosító jel</Form.Label>
          <Form.Control disabled value={taxNumber} />
        </Form.Group>
        <Form.Group className="mb-3" controlId="taxNumber">
          <Form.Label>Név</Form.Label>
          <Form.Control disabled value={useAppSelector(userRealName)} />
        </Form.Group>
        <Form.Group className="mb-3" controlId="taxNumber">
          <Form.Label>Cég</Form.Label>
          <Form.Control disabled value={useAppSelector(companyName)} />
        </Form.Group>
        <Form.Group>
          <Form.Label>Email cím</Form.Label>
          <InputGroup className="mb-3">
            <Form.Control
              aria-label="Email cím"
              aria-describedby="userEmail"
              isInvalid={!!emailAddressError}
              onChange={onEmailChange}
              value={emailAddress}
            />
            <Button
              disabled={!!emailAddressError}
              id="userEmail"
              onClick={setNewEmailAddress}
              variant="primary"
            >
              Mentés
            </Button>
            <Form.Control.Feedback type="invalid">{emailAddressError}</Form.Control.Feedback>
          </InputGroup>
        </Form.Group>
        <Form.Group className="mb-3" controlId="userPassword">
          <Form.Label>
            Új jelszó
            <ul>
              <li>Minimum 8 karakter</li>
              <li>Minimum 1 kisbetű</li>
              <li>Minimum 1 nagybetű</li>
              <li>Minimum 1 számjegy</li>
              <li>Nem egyezhet meg az előző jelszóval</li>
            </ul>
          </Form.Label>
          <Form.Control
            isInvalid={!!passwordError}
            isValid={!!passwordSuccess}
            onChange={
              (e: React.ChangeEvent<HTMLInputElement>) => setPassword(e.target.value)
            }
            type="password"
            value={password}
          />
        </Form.Group>
        <Form.Group>
          <Form.Label>Új jelszó újra</Form.Label>
          <InputGroup className="mb-3">
            <Form.Control
              aria-label="Jelszó újra"
              aria-describedby="userPassword2"
              isInvalid={!!passwordError}
              isValid={!!passwordSuccess}
              onChange={
                (e: React.ChangeEvent<HTMLInputElement>) => setPasswordRepeat(e.target.value)
              }
              type="password"
              value={passwordRepeat}
            />
            <Button
              id="userPassword2"
              onClick={setNewPassword}
              variant="primary"
            >
              Mentés
            </Button>
            {passwordError
              && (
                <Form.Control.Feedback type="invalid">
                  {passwordError}
                </Form.Control.Feedback>
              )}
            {passwordSuccess
              && (
                <Form.Control.Feedback type="valid">
                  {passwordSuccess}
                </Form.Control.Feedback>
              )}
          </InputGroup>
        </Form.Group>
      </Form>
    </Container>
  );
};

export default Profile;
