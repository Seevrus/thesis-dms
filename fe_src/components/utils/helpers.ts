import { OptionsT } from 'interfaces/common';
import { paramCase } from 'param-case';

export const createOption = (label: string): OptionsT => ({
  label,
  value: paramCase(label),
});

export const testEmailAddress = (emailAddress: string) => {
  const emailRegex = /^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[A-Za-z]+$/;
  return emailRegex.test(emailAddress);
};

export const testEmailCode = (code: string) => {
  const emailCodeRegex = /^\d{6}$/;
  return emailCodeRegex.test(code);
};

export const testPassword = (password: string) => {
  const passwordRegex = /^(?=.*[a-záéíóőúű])(?=.*[A-ZÁÉÍÓŐÚŰ])(?=.*\d)[_a-záéíóőúűA-ZÁÉÍÓŐÚŰ\d]{8,}$/;
  return passwordRegex.test(password);
};

export const testTaxNumber = (taxNumberInput: string) => {
  const taxNumberRegex = /^[1-9]\d{9}$/;
  return taxNumberRegex.test(taxNumberInput);
};
