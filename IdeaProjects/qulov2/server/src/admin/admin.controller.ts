import type { Request, Response } from "express";
import { adminService } from "./admin.service.js";

class AdminController {
  loginPage(req: Request, res: Response) {
    if (req.session.adminId) return res.redirect("/admin");
    res.render("login", { error: null, csrfToken: req.session.csrfToken });
  }

  async loginPost(req: Request, res: Response) {
    const { email, password } = req.body;
    const admin = await adminService.validateLogin(email, password);
    if (!admin) {
      return res.render("login", { error: "Invalid credentials", csrfToken: req.session.csrfToken });
    }
    req.session.adminId = admin.id;
    req.session.adminEmail = admin.email;
    req.session.adminRole = admin.role;
    res.redirect("/admin");
  }

  logout(req: Request, res: Response) {
    req.session.destroy(() => {
      res.redirect("/admin/login");
    });
  }

  async dashboard(req: Request, res: Response) {
    const stats = await adminService.getDashboardStats();
    res.render("dashboard", { stats, session: req.session });
  }

  async users(req: Request, res: Response) {
    const page = parseInt(req.query.page as string) || 1;
    const search = req.query.search as string;
    const gender = req.query.gender as string;
    const { users, total } = await adminService.getUsers(page, 20, search, gender);
    const totalPages = Math.ceil(total / 20);
    res.render("users", { users, page, totalPages, total, search: search || "", gender: gender || "all", session: req.session });
  }

  async userDetail(req: Request, res: Response) {
    const { user, details, questions } = await adminService.getUserDetail(req.params.id as string);
    if (!user) return res.status(404).render("error", { message: "User not found", session: req.session });
    res.render("user-detail", { user, details, questions, session: req.session, csrfToken: req.session.csrfToken });
  }

  async userAction(req: Request, res: Response) {
    const id = req.params.id as string;
    const { action, green_diamonds, purple_diamonds } = req.body;

    if (action === "ban") await adminService.banUser(id);
    else if (action === "unban") await adminService.unbanUser(id);
    else if (action === "delete") await adminService.deleteUser(id);
    else if (action === "update_diamonds") {
      await adminService.updateDiamonds(id, parseInt(green_diamonds), parseInt(purple_diamonds));
    }

    res.redirect(`/admin/users/${id}`);
  }

  async reports(req: Request, res: Response) {
    const page = parseInt(req.query.page as string) || 1;
    const status = req.query.status as string;
    const { reports, total } = await adminService.getReports(page, 20, status);
    const totalPages = Math.ceil(total / 20);
    res.render("reports", { reports, page, totalPages, total, status: status || "all", session: req.session });
  }

  async reportDetail(req: Request, res: Response) {
    const result = await adminService.getReportDetail(req.params.id as string);
    if (!result) return res.status(404).render("error", { message: "Report not found", session: req.session });
    res.render("report-detail", { ...result, session: req.session, csrfToken: req.session.csrfToken });
  }

  async reportAction(req: Request, res: Response) {
    const id = req.params.id as string;
    const { status, ban_user } = req.body;
    await adminService.updateReportStatus(id, status);
    if (ban_user) {
      const detail = await adminService.getReportDetail(id);
      if (detail?.reported) await adminService.banUser(detail.reported.id);
    }
    res.redirect(`/admin/reports/${id}`);
  }

  async matches(req: Request, res: Response) {
    const page = parseInt(req.query.page as string) || 1;
    const active = req.query.active as string;
    const { matches, total } = await adminService.getMatches(page, 20, active);
    const totalPages = Math.ceil(total / 20);
    res.render("matches", { matches, page, totalPages, total, active: active || "all", session: req.session });
  }

  async transactions(req: Request, res: Response) {
    const page = parseInt(req.query.page as string) || 1;
    const type = req.query.type as string;
    const userId = req.query.userId as string;
    const { transactions, total } = await adminService.getTransactions(page, 30, type, userId);
    const totalPages = Math.ceil(total / 30);
    res.render("transactions", { transactions, page, totalPages, total, type: type || "all", userId: userId || "", session: req.session });
  }

  async quizStats(req: Request, res: Response) {
    const stats = await adminService.getQuizStats();
    res.render("quiz-stats", { stats, session: req.session });
  }

  async admins(req: Request, res: Response) {
    const admins = await adminService.getAdmins();
    res.render("admins", { admins, session: req.session, csrfToken: req.session.csrfToken, error: null });
  }

  async createAdmin(req: Request, res: Response) {
    const { email, password, role } = req.body;
    try {
      await adminService.createAdmin(email, password, role || "ADMIN");
      res.redirect("/admin/admins");
    } catch (e: any) {
      const admins = await adminService.getAdmins();
      res.render("admins", { admins, session: req.session, csrfToken: req.session.csrfToken, error: e.message });
    }
  }

  async deleteAdminAction(req: Request, res: Response) {
    if ((req.params.id as string) === req.session.adminId) {
      return res.redirect("/admin/admins");
    }
    await adminService.deleteAdmin(req.params.id as string);
    res.redirect("/admin/admins");
  }
}

export const adminController = new AdminController();
