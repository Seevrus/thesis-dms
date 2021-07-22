import React from 'react';
import {
  Container,
  Nav,
  Navbar,
} from 'react-bootstrap';
import Countdown from 'react-countdown';
import { useSelector } from 'react-redux';
import { useHistory } from 'react-router';
import { Link } from 'react-router-dom';

import { userLoginStatus, loginExpires, LOGIN_STATUS } from '../../store/usersSlice';

const NavigationBar = () => {
  const history = useHistory();

  const loggedin = useSelector(userLoginStatus);
  const expires = useSelector(loginExpires);

  if (expires) {
    const idleCheck = setInterval(() => {
      if ((expires * 1000 - Date.now() < 0)) {
        clearInterval(idleCheck);
        history.push('/logout');
      }
    }, 5000);
  }

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

  return loggedin === LOGIN_STATUS.LOGGED_IN && (
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
          <Nav.Item>
            <Link to="/logout">
              Kijelentkezés  (
              {countDown}
              )
            </Link>
          </Nav.Item>
        </Nav>
      </Container>
    </Navbar>
  );
};

export default NavigationBar;
