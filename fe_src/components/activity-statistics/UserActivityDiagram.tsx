import { Card, Col, Row } from 'react-bootstrap';

const UserActivityDiagram = () => (
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
);

export default UserActivityDiagram;
