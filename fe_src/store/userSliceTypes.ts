import { BaseResponseT, OutcomeT } from './commonTypes';

export enum UserPermissionsEnum {
  INACTIVE = 'INACTIVE',
  USER = 'USER',
  ACTIVITY_ADMINISTRATOR = 'ACTIVITY_ADMINISTRATOR',
  USER_ADMINISTRATOR = 'USER_ADMINISTRATOR',
  DOCUMENT_CREATOR = 'DOCUMENT_CREATOR',
}

export enum EmailStatusEnum {
  NO_EMAIL = 'NO_EMAIL',
  NOT_VALIDATED = 'NOT_VALIDATED',
  VALID_EMAIL = 'VALID_EMAIL',
}

export enum LoginStatusEnum {
  NOT_LOGGED_IN = 'NOT_LOGGED_IN',
  LOGGED_IN = 'LOGGED_IN',
}

export interface UpdateProfileRequestT {
  taxNumber: number;
  userRealName?: string;
  companyName?: string;
  email?: string;
  ownEmail?: boolean;
  password?: string;
  attempts?: boolean;
}

interface UserRealNameResponseT extends BaseResponseT {
  value: 'userRealName';
  userRealName: string;
}

interface CompanyNameResponseT extends BaseResponseT {
  value: 'companyName';
  companyName: string;
}

export interface ModifyEmailResponseT extends BaseResponseT {
  value: 'userEmail';
  emailStatus?: EmailStatusEnum;
  userEmail: string;
  ownEmail: boolean;
}

interface ModifyPasswordResponseT extends BaseResponseT {
  value: 'password';
}

interface AttemptsResponseT extends BaseResponseT {
  value: 'attempts';
}

export type UpdateProfileResponseT = [
  UserRealNameResponseT?,
  CompanyNameResponseT?,
  ModifyEmailResponseT?,
  ModifyPasswordResponseT?,
  AttemptsResponseT?,
];

export interface EmailValidationRequestT {
  emailCode: string;
}

export interface EmailValidationResponseT extends BaseResponseT {
  emailStatus: EmailStatusEnum;
}

export interface LoginRequestT {
  taxNumber: number;
  password: string;
}

export interface LoginResponseT extends BaseResponseT {
  emailStatus?: `${EmailStatusEnum}`;
  expires?: number;
  loginStatus?: `${LoginStatusEnum}`;
  taxNumber?: number;
  companyName?: string;
  userRealName?: string;
  userEmail?: string;
  userPermissions?: `${UserPermissionsEnum}`[];
}

export interface LogoutResponseT extends BaseResponseT {
  loginStatus?: `${LoginStatusEnum}`;
}

export interface UserSliceT {
  loginStatus: `${LoginStatusEnum}`;
  expires: number;
  taxNumber: number;
  companyName: string;
  userRealName: string;
  userPermissions: `${UserPermissionsEnum}`[];
  userEmail: string;
  emailStatus: `${EmailStatusEnum}`;
  outcome: OutcomeT;
  message: string;
}
