import React, { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { login, selectErrorMessage } from '../../../store/usersSlice';

const LoginForm = () => {
  const dispatch = useDispatch();

  const [taxNumber, setTaxNumber] = useState('1315760217');
  const [loginPwd, setLoginPwd] = useState('49937335');
  const [taxNumberError, setTaxNumberError] = useState('');
  const [loginError, setLoginError] = useState('');

  const onTaxNumberChange = (e) => {
    const taxNumberInput = e.target.value;
    // Only numbers:
    const re = /^[0-9\b]+$/;

    if (taxNumberInput === '' || (re.test(taxNumberInput) && taxNumberInput < 1e10)) {
      setTaxNumber(taxNumberInput);
    }
  };

  const onLoginPwdChange = (e) => {
    const loginPwdInput = e.target.value;
    // Only letters and numbers:
    const re = /^[A-Za-z0-9áéíóőúűÁÉÍÓŐŰ]*$/;

    if (loginPwdInput === '' || re.test(loginPwdInput)) {
      setLoginPwd(loginPwdInput);
    }
  };

  const onLoginAttempt = async (e) => {
    e.preventDefault();
    setLoginError('');

    if (taxNumber < 1e9 || taxNumber > 1e10) {
      setTaxNumberError('Hiba: Az adóazonosító jel 10 számjegyből állhat!');
      return false;
    }

    setTaxNumberError('');
    dispatch(login({ taxNumber, loginPwd }))
      .then(() => {
        setLoginError(useSelector(selectErrorMessage));
      });
  };

  return (
    <div className="container">
      <div className="row justify-content-md-center">
        <div className="col col-lg-4">
          <form>
            <div className="mb-3">
              <label htmlFor="tax-number" className="form-label">Adóazonosító jel</label>
              <input
                name="tax-number"
                className="form-control"
                id="tax-number"
                value={taxNumber}
                onChange={onTaxNumberChange}
                required
              />
            </div>
            {taxNumberError && (
              <div className="alert alert-danger" role="alert">
                {taxNumberError}
              </div>
            )}
            <div className="mb-3">
              <label htmlFor="login-pwd" className="form-label">Jelszó</label>
              <input
                name="login-pwd"
                type="password"
                className="form-control"
                id="login-pwd"
                value={loginPwd}
                onChange={onLoginPwdChange}
                required
              />
            </div>
            <button type="button" className="btn btn-primary" onClick={onLoginAttempt}>Belépés</button>
            <button type="button" className="btn btn-primary" disabled>Elfelejtettem a jelszavam</button>
            {loginError && (
              <div className="alert alert-danger" role="alert">
                {loginError}
              </div>
            )}
          </form>
        </div>
      </div>
    </div>
  );
};

export default LoginForm;
