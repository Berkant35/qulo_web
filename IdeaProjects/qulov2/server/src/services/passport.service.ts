import { supabase } from "../config/supabase.js";
import { diamondService } from "./diamond.service.js";
import { Errors } from "../utils/errors.js";

export class PassportService {
  async activate(userId: string, city: string, lat: number, lng: number) {
    // Spend 50 purple diamonds
    await diamondService.spendPurple(userId, 50, "PASSPORT");

    // Update user passport fields
    const { error } = await supabase
      .from("users")
      .update({
        passport_city: city,
        passport_lat: lat,
        passport_lng: lng,
        updated_at: new Date().toISOString(),
      })
      .eq("id", userId);

    if (error) {
      throw Errors.SERVER_ERROR();
    }

    return { passport_city: city, passport_lat: lat, passport_lng: lng };
  }

  async deactivate(userId: string) {
    const { error } = await supabase
      .from("users")
      .update({
        passport_city: null,
        passport_lat: null,
        passport_lng: null,
        updated_at: new Date().toISOString(),
      })
      .eq("id", userId);

    if (error) {
      throw Errors.SERVER_ERROR();
    }

    return { message: "Passport deactivated" };
  }
}

export const passportService = new PassportService();
