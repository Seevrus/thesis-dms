import { OptionsT } from 'interfaces/common';
import { paramCase } from 'param-case';

// eslint-disable-next-line import/prefer-default-export
export const createOption = (label: string): OptionsT => ({
  label,
  value: paramCase(label),
});
