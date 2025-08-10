import { BaseResponseT } from "../commonTypes.ts";
import { UserSearchTypeEnum } from '../otherUsers/otherUsersSliceTypes';

export interface DeliveryT {
  lastWeek: number;
  lastMonth: number;
  moreThanOneMonth: number;
  notDownloaded: number;
}

export interface LastLoginT {
  lastWeek: number;
  lastTwoWeeks: number;
  lastMonth: number;
  lastTwoMonths: number;
  lastThreeMonths: number;
  lastSixMonths: number;
  moreThanSixMonths: number;
}

export interface SimpleUserT {
  taxNumber: number;
  companyName: string;
  userRealName: string;
  lastLogin: Date;
}

export interface DeliveryStatisticsResponseT extends BaseResponseT {
  payroll: DeliveryT;
  info: DeliveryT;
}

export interface LoginStatisticsResponseT extends BaseResponseT {
  statistics: LastLoginT;
}

export interface SearchSimpleUserRequestT {
  keyword: string | number;
  searchType: UserSearchTypeEnum.LAST_LOGIN;
}

export interface SearchSimpleUserResponseT extends BaseResponseT {
  users: SimpleUserT[];
}

export interface StatisticsRequestT {
  companyName?: string;
}

export interface StatisticsSliceT {
  lastLogin: LastLoginT;
  payrollDelivery: DeliveryT;
  infoLetterDelivery: DeliveryT;
  simpleUsers: SimpleUserT[];
  selectedUser: SimpleUserT;
}
