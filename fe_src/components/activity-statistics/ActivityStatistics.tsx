import { useEffect, useState } from 'react';
import { Container } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

import { useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/user/userSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/user/userSlice';
import Loading from '../utils/Loading';
import AvgDeliveryTime from './AvgDeliveryTime';
import UserActivityDiagram from './UserActivityDiagram';

const ActivityStatistics = () => {
  const navigate = useNavigate();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  useEffect(() => {
    document.title = 'Felhasználói statisztika';
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

    if (loginStatus === LoginStatusEnum.NOT_LOGGED_IN) {
      navigate('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      navigate('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      navigate('/validate-email');
    }
  }, [emailStatus, navigate, loginStatus]);
  // End of redirections

  if (isComponentLoading) {
    return <Loading />;
  }

  return (
    <Container fluid>
      <UserActivityDiagram />
      <AvgDeliveryTime />
    </Container>
  );
};

export default ActivityStatistics;
