import React from 'react';
import {
  Container,
  Nav,
  Navbar,
} from 'react-bootstrap';
import Countdown from 'react-countdown';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router';
import { Link } from 'react-router-dom';

import {
  checkLoginStatus,
  loginExpires,
  LOGIN_STATUS,
  userLoginStatus,
} from '../../store/usersSlice';

const NavigationBar = () => {
  const dispatch = useDispatch();
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

  const recordActivity = (e) => {
    if (e.target.href && !e.target.href.includes('/logout')) {
      dispatch(checkLoginStatus());
    }
  };

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
    <Navbar collapseOnSelect bg="light" expand="lg" onClick={recordActivity}>
      <Container>
        <Nav className="home-page-link">
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Link to="/" className="navbar-brand">
            Kezdőlap
          </Link>
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
            <Link to="/logout" className="nav-link">
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
