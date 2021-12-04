/* eslint-disable react/prop-types */
/* eslint-disable no-plusplus */
/* eslint-disable func-names */
/* eslint-disable react/no-this-in-sfc */
/*!

=========================================================
* Light Bootstrap Dashboard React - v2.0.0
=========================================================

* Product Page: https://www.creative-tim.com/product/light-bootstrap-dashboard-react
* Copyright 2020 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/light-bootstrap-dashboard-react/blob/master/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice
shall be included in all copies or substantial portions of the Software.

*/
import * as React from 'react';
import Countdown from 'react-countdown';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import {
  Button,
  Container,
  Nav,
  Navbar,
} from 'react-bootstrap';

import { useAppSelector, useAppDispatch } from '../../store/hooks';
import { checkLoginStatus, loginExpires } from '../../store/user/userSlice';

function Header({ routes }) {
  const dispatch = useAppDispatch();
  const expires = useAppSelector(loginExpires);
  const navigate = useNavigate();

  const location = useLocation();
  const mobileSidebarToggle = (e) => {
    e.preventDefault();
    document.documentElement.classList.toggle('nav-open');
    const node = document.createElement('div');
    node.id = 'bodyClick';
    node.onclick = function () {
      this.parentElement.removeChild(this);
      document.documentElement.classList.toggle('nav-open');
    };
    document.body.appendChild(node);
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

  const getBrandText = () => {
    for (let i = 0; i < routes.length; i++) {
      if (location.pathname.indexOf(routes[i].layout + routes[i].path) !== -1) {
        return routes[i].name;
      }
    }
    return 'Dokumentumok';
  };

  if (expires) {
    const idleCheck = setInterval(() => {
      if ((expires * 1000 - Date.now() < 0)) {
        clearInterval(idleCheck);
        navigate('/logout');
      }
    }, 5000);
  }

  const recordActivity = () => dispatch(checkLoginStatus());

  return (
    <Navbar bg="light" expand="lg">
      <Container fluid>
        <div className="d-flex justify-content-center align-items-center ml-2 ml-lg-0">
          <Button
            variant="dark"
            className="d-lg-none btn-fill d-flex justify-content-center align-items-center rounded-circle p-2"
            onClick={mobileSidebarToggle}
          >
            <i className="fas fa-ellipsis-v" />
          </Button>
          <Navbar.Brand className="mr-2">
            {getBrandText()}
          </Navbar.Brand>
        </div>
        <Navbar.Toggle aria-controls="basic-navbar-nav" className="mr-2">
          <span className="navbar-toggler-bar burger-lines" />
          <span className="navbar-toggler-bar burger-lines" />
          <span className="navbar-toggler-bar burger-lines" />
        </Navbar.Toggle>
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="ml-auto" navbar>
            <Nav.Item>
              <Link to="/profile" className="m-0 nav-link" onClick={recordActivity}>
                <span className="no-icon">Profilom</span>
              </Link>
            </Nav.Item>
            <Nav.Item>
              <Link to="/logout" className="m-0 nav-link">
                <span className="no-icon">
                  Kijelentkezés
                  {' '}
                  {countDown}
                </span>
              </Link>
            </Nav.Item>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}

export default Header;
