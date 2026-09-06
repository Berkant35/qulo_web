/**
 * Purple-diamond reward each side of a referral receives once the invitee
 * activates. Mirrors qulo-server economy config `rewards.referralPurple`
 * (currently 25) and the mobile copy `referral_description`. The site cannot
 * read the live config (static export), so keep this in sync by hand when the
 * economy config changes.
 */
export const REFERRAL_REWARD_PURPLE = 25;
