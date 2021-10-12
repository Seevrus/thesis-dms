import * as React from 'react';
import {
  Button,
  Container,
  Form,
  InputGroup,
} from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppSelector } from '../../store/hooks';
import { EmailStatusEnum } from '../../store/usersSliceTypes';
import {
  companyName,
  userEmailStatus,
  userRealName,
  userTaxNumber,
} from '../../store/usersSlice';

const { useEffect, useState } = React;

const Profile = () => {
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

  const [isFormValidated, setIsFormValidated] = useState(false);

  return (
    <Container className="form-container">
      <h3 className="page-title text-center">Profilom</h3>
      <Form noValidate validated={isFormValidated}>
        <Form.Group className="mb-3" controlId="taxNumber">
          <Form.Label>Adóazonosító jel</Form.Label>
          <Form.Control disabled value={useAppSelector(userTaxNumber)} />
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
            />
            <Button variant="primary" id="userEmail">
              Mentés
            </Button>
          </InputGroup>
        </Form.Group>
        <Form.Group>
          <Form.Label>Jelszó</Form.Label>
          <InputGroup className="mb-3">
            <Form.Control
              aria-label="Jelszó"
              aria-describedby="userPassword"
              type="password"
            />
            <Button variant="primary" id="userPassword">
              Mentés
            </Button>
          </InputGroup>
        </Form.Group>
        <Form.Group>
          <Form.Label>Jelszó újra</Form.Label>
          <InputGroup className="mb-3">
            <Form.Control
              aria-label="Jelszó újra"
              aria-describedby="userPassword2"
              type="password"
            />
            <Button variant="primary" id="userPassword2">
              Mentés
            </Button>
          </InputGroup>
        </Form.Group>
      </Form>
    </Container>
  );
};

export default Profile;
