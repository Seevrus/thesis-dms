import * as React from 'react';
import { Col, Container, Row } from 'react-bootstrap';

import NavigationBar from './NavigationBar';

const Header = () => (
  <Container className="mt-5 mb-5">
    <Row className="d-flex">
      <Col className="col-3 align-self-center">
        <h3 className="text-center">Logó helye</h3>
      </Col>
      <Col className="col-8 align-self-center">
        <h3 className="text-center">Szentistváni Mezőgazdasági Zrt.</h3>
      </Col>
    </Row>
    <NavigationBar />
  </Container>
);

export default Header;
