import * as React from 'react';
import { Container } from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/usersSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/usersSlice';
import Loading from '../utils/Loading';

const { useEffect, useState } = React;

const UserHandling = () => {
  const history = useHistory();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  const loginStatus = useAppSelector(userLoginStatus);
  useEffect(() => {
    if (!emailStatus) {
      setIsComponentLoading(true);
    } else {
      setIsComponentLoading(false);
    }

    if (loginStatus === LoginStatusEnum.NOT_LOGGED_IN) {
      history.push('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus, loginStatus]);
  // End of redirections

  if (isComponentLoading) {
    return (
      <Container className="mt-5 mb-5">
        <Loading />
      </Container>
    );
  }

  return (
    <Container className="mt-5 mb-5">
      <h3 className="page-title text-center">Felhasználók kezelése</h3>
    </Container>
  );
};

export default UserHandling;
