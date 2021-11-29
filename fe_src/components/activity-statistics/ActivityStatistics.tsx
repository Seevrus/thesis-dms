import { useEffect, useState } from 'react';
import {
  Card,
  Col,
  Container,
  Row,
} from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

import { useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/userSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/userSlice';
import Loading from '../utils/Loading';

const ActivityStatistics = () => {
  const navigate = useNavigate();

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
      <Card>
        <Card.Header>
          <Card.Title as="h4">Felhasználói aktivitás</Card.Title>
        </Card.Header>
        <Card.Body>
          <Row>
            <Col md="8">
              Ide kerül egy oszlopdiagram
            </Col>
            <Col md="4">Egyedi felhasználó</Col>
          </Row>
        </Card.Body>
      </Card>

      <Card>
        <Card.Header>
          <Card.Title as="h4">Átlagos kézbesítési idő</Card.Title>
        </Card.Header>
        <Card.Body>
          <Row>
            <Col md="6">
              Ide kerül egy tortadiagram
            </Col>
            <Col md="6">
              És ide egy másik
            </Col>
          </Row>
        </Card.Body>
      </Card>
    </Container>
  );
};

export default ActivityStatistics;
