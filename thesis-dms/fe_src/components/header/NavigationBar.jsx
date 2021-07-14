import React from 'react';
import {
  Container,
  Nav,
  Navbar,
} from 'react-bootstrap';
import Countdown from 'react-countdown';
import { useSelector } from 'react-redux';

import { loginExpires } from '../../store/usersSlice';

const NavigationBar = () => {
  const expires = useSelector(loginExpires);
  const countDown = expires && (
  <Countdown
    date={new Date(expires * 1000)}
    renderer={({ minutes, seconds }) => (
      <span>
        {minutes}
        :
        {seconds < 10 ? `0${seconds}` : seconds}
      </span>
    )}
  />
  );

  return (
    <Navbar collapseOnSelect bg="light" expand="lg">
      <Container>
        <Nav className="home-page-link">
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Brand href="#home">Kezdőlap</Navbar.Brand>
        </Nav>
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link href="#home">Dokumentumaim</Nav.Link>
            <Nav.Link href="#link">Felhasználói aktivitás</Nav.Link>
            <Nav.Link href="#link">Felhasználók kezelése</Nav.Link>
          </Nav>
          <Nav>
            <Nav.Link href="#deets">Profilom</Nav.Link>
          </Nav>
        </Navbar.Collapse>
        <Nav>
          <Nav.Link href="#deets">
            Kijelentkezés  (
            {countDown}
            )
          </Nav.Link>
        </Nav>
      </Container>
    </Navbar>
  );
};

export default NavigationBar;
