import { supabase } from '../config/supabase.js';
import { NotificationService } from './notification.service.js';
import { questionService } from './question.service.js';

class WeeklyReportService {
  async sendWeeklyReports() {
    const { data: users } = await supabase
      .from('users')
      .select('id, locale')
      .eq('is_deleted', false);

    let sent = 0;
    for (const user of users ?? []) {
      try {
        const report = await questionService.getWeeklyReport(user.id);
        if (report.total_solves === 0) continue;

        await NotificationService.sendPush(user.id, 'campaign', {
          body: `Bu hafta soruların ${report.total_solves} kez çözüldü, ${report.green_earned} yeşil elmas kazandın!`,
        }, undefined, {
          title: 'Haftalık Raporun',
          actionUrl: '/profile/questions/analytics',
        });
        sent++;
      } catch {
        // Skip failed users
      }
    }
    return { sent };
  }
}

export const weeklyReportService = new WeeklyReportService();
