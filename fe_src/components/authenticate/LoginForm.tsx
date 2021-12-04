import { useEffect, useState } from 'react';
import {
  Alert,
  Button,
  Card,
  Col,
  Container,
  Form,
  Row,
} from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum } from '../../store/user/userSliceTypes';
import { login, userEmailStatus, userLoginStatus } from '../../store/user/userSlice';
import Password from '../form-components/Password';
import TaxNumber from '../form-components/TaxNumber';
import { testTaxNumber } from '../utils/helpers';
import Loading from '../utils/Loading';

const LoginForm = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  useEffect(() => {
    document.title = 'Thesis-DMS';
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

    if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      navigate('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      navigate('/validate-email');
    } else if (emailStatus === EmailStatusEnum.VALID_EMAIL) {
      navigate('/documents');
    }
  }, [emailStatus, navigate, loginStatus]);
  // End of redirections

  const [isFormValidated, setIsFormValidated] = useState<boolean>(false);
  const [taxNumber, setTaxNumber] = useState<string>('8713053299');
  const [loginPassword, setLoginPassword] = useState<string>('jelszo');
  const [taxNumberError, setTaxNumberError] = useState<string>('');
  const [loginError, setLoginError] = useState<string>('');

  const onLoginAttempt = async (e: React.MouseEvent) => {
    e.preventDefault();
    let canSubmit = true;
    setIsFormValidated(false);
    setLoginError('');
    const requestTaxNumber = Number(taxNumber);

    if (!testTaxNumber(taxNumber)) {
      setTaxNumberError('Hiba: Az adóazonosító jel formátuma nem megfelelő!');
      canSubmit = false;
    }

    if (canSubmit) {
      setTaxNumberError('');
      setIsFormValidated(true);
      setIsComponentLoading(true);
      dispatch(login({ taxNumber: requestTaxNumber, password: loginPassword }))
        .catch((err) => {
          setIsComponentLoading(false);
          setIsFormValidated(false);
          setLoginError(`Hiba: ${err.message}`);
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
    <Container fluid>
      <Row className="justify-content-md-center">
        <Col md="8">
          <Card className="login">
            <Card.Header>
              <Card.Title as="h4">Thesis-DMS Bejelentkezés</Card.Title>
            </Card.Header>
            <Card.Body>
              <Form noValidate validated={isFormValidated}>
                <TaxNumber
                  taxNumber={taxNumber}
                  setTaxNumber={setTaxNumber}
                  taxNumberError={taxNumberError}
                  feedback
                />
                <Password
                  password={loginPassword}
                  setPassword={setLoginPassword}
                  showRequirements={false}
                  requireValidation={false}
                />
                <Button onClick={onLoginAttempt} variant="primary">
                  Belépés
                </Button>
              </Form>
              {loginError && (
                <Alert variant="danger">{loginError}</Alert>
              )}
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default LoginForm;
