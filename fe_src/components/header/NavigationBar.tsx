import {
  Container,
  Nav,
  Navbar,
} from 'react-bootstrap';
import Countdown from 'react-countdown';
import { Link, useNavigate } from 'react-router-dom';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { LoginStatusEnum } from '../../store/userSliceTypes';
import {
  checkLoginStatus,
  loginExpires,
  userLoginStatus,
} from '../../store/userSlice';

const NavigationBar = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  const loggedin = useAppSelector(userLoginStatus);
  const expires = useAppSelector(loginExpires);

  if (expires) {
    const idleCheck = setInterval(() => {
      if ((expires * 1000 - Date.now() < 0)) {
        clearInterval(idleCheck);
        navigate('/logout');
      }
    }, 5000);
  }

  const recordActivity = (e: React.MouseEvent<HTMLAnchorElement>) => {
    const { href } = e.target as HTMLAnchorElement;
    if (href && !href.includes('/logout')) {
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

  return loggedin === LoginStatusEnum.LOGGED_IN && (
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
            <Link to="/documents" className="nav-link">Dokumentumaim</Link>
            <Link to="/user-activity" className="nav-link">Felhasználói aktivitás</Link>
            <Link to="/user-handling" className="nav-link">Felhasználók kezelése</Link>
          </Nav>
          <Nav>
            <Link to="/profile" className="nav-link">Profilom</Link>
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
