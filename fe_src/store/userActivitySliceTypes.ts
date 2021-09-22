export interface UserActivityRequestT {
  companyName?: string;
  userRealName?: string;
  categoryName?: string;
  documentName?: string;
  added?: string;
  validUntil?: string;
  downloaded?: string;
}

export interface UserActivityT {
  id: number;
  companyName: string;
  userRealName: string;
  categoryName: string;
  documentName: string;
  added: Date;
  validUntil: Date;
  downloadedAt: Date;
}
