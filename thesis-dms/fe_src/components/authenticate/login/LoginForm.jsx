import React, { useState } from 'react';

const LoginForm = () => {
  const [taxNumber, setTaxNumber] = useState('');
  const [loginPwd, setLoginPwd] = useState('');

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
            <button type="button" className="btn btn-primary">Belépés</button>
            <button type="button" className="btn btn-primary" disabled>Elfelejtettem a jelszavam</button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default LoginForm;
