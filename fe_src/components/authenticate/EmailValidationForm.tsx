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
  userEmailStatus,
  userLoginStatus,
  validateEmailAddress,
} from '../../store/userSlice';

import EmailCode from '../form-components/EmailCode';
import { testEmailCode } from '../utils/helpers';
import Loading from '../utils/Loading';

const EmailValidationForm = () => {
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
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      history.push('/complete-registration');
    }
  }, [emailStatus, history, loginStatus]);
  // End of redirections

  const [isFormValidated, setIsFormValidated] = useState<boolean>(false);
  const [emailCode, setEmailCode] = useState<string>('');
  const [emailCodeError, setEmailCodeError] = useState<string>('');
  const [validationError, setValidationError] = useState<string>('');

  const onEmailValidationAttempt = (e: React.MouseEvent) => {
    e.preventDefault();
    let canSubmit = true;
    setIsFormValidated(false);
    setEmailCodeError('');
    setValidationError('');

    if (!emailCode) {
      setEmailCodeError('Hiba: A kód megadása kötelező!');
      canSubmit = false;
    } else if (!testEmailCode(emailCode)) {
      setEmailCodeError('Hiba: A kód formátuma nem megfelelő!');
      canSubmit = false;
    }

    if (canSubmit) {
      setEmailCodeError('');
      setIsFormValidated(true);
      setIsComponentLoading(true);
      dispatch(validateEmailAddress({ emailCode }))
        .then(() => history.push('/documents'))
        .catch((err) => {
          setIsComponentLoading(false);
          setIsFormValidated(false);
          setValidationError(err.message);
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
          Email cím regisztrációjának befejezéséhez kérem adja meg a korábban megadott email címére kiküldött ellenőrző kódot az erre szolgáló mezőben. Ezt követően már hozzá for férni a dokumentumkezelő rendszerhez. Amennyiben nem találja a kiküldött üzenetet, kérem, ellenőrizze le a Spam/Levélszemét mappát is.
        </p>
      </Container>
      <Container className="form-container" fluid="md">
        <Form noValidate validated={isFormValidated}>
          <EmailCode
            emailCode={emailCode}
            setEmailCode={setEmailCode}
            emailCodeError={emailCodeError}
          />
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
