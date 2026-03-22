import type { Metadata } from "next";
import Link from "next/link";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";

export const metadata: Metadata = {
  title: "About — QuloApp",
  description:
    "Learn about the team and mission behind QuloApp — a smarter way to connect, collaborate, and grow.",
};

const team = [
  {
    name: "Berkant Çalıkuşu",
    role: "Founder & CEO",
    bio: "Passionate about building tools that empower people to do their best work.",
  },
  {
    name: "Jordan Lee",
    role: "Head of Product",
    bio: "Obsessed with turning complex problems into simple, delightful experiences.",
  },
  {
    name: "Maria Santos",
    role: "Lead Engineer",
    bio: "Full-stack developer with a passion for performance and elegant code.",
  },
];

export default function AboutPage() {
  return (
    <>
      <Navbar />

      {/* Hero */}
      <section className="pt-32 pb-16 px-4 sm:px-6 lg:px-8 bg-gradient-to-b from-indigo-50 to-white">
        <div className="max-w-3xl mx-auto text-center">
          <h1 className="text-4xl sm:text-5xl font-extrabold text-gray-900 mb-6">
            We&apos;re building the future of collaboration
          </h1>
          <p className="text-xl text-gray-600">
            QuloApp was founded with a single mission: give every team the tools
            they need to work smarter, move faster, and achieve more — together.
          </p>
        </div>
      </section>

      {/* Mission */}
      <section className="py-16 px-4 sm:px-6 lg:px-8 bg-white">
        <div className="max-w-4xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
          <div>
            <h2 className="text-3xl font-extrabold text-gray-900 mb-4">Our Mission</h2>
            <p className="text-gray-600 leading-relaxed mb-4">
              We believe great software should feel effortless. Too many teams
              struggle with fragmented workflows, endless context-switching, and
              tools that get in the way rather than helping.
            </p>
            <p className="text-gray-600 leading-relaxed">
              QuloApp unifies the tools, conversations, and data that modern
              teams rely on — so you spend less time managing software and more
              time doing meaningful work.
            </p>
          </div>
          <div className="bg-indigo-50 rounded-2xl p-8 space-y-6">
            {[
              { stat: "10k+", label: "Teams using QuloApp" },
              { stat: "99.9%", label: "Uptime SLA" },
              { stat: "50+", label: "Integrations available" },
            ].map(({ stat, label }) => (
              <div key={label}>
                <div className="text-4xl font-extrabold text-indigo-600">{stat}</div>
                <div className="text-sm text-gray-600">{label}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Team */}
      <section className="py-16 px-4 sm:px-6 lg:px-8 bg-gray-50">
        <div className="max-w-5xl mx-auto">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-extrabold text-gray-900 mb-4">Meet the team</h2>
            <p className="text-gray-600">
              A small but mighty group of builders, designers, and dreamers.
            </p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-8">
            {team.map((member) => (
              <div key={member.name} className="bg-white rounded-2xl p-6 border border-gray-100 text-center">
                <div className="w-16 h-16 rounded-full bg-indigo-100 flex items-center justify-center mx-auto mb-4 text-indigo-600 text-xl font-bold">
                  {member.name.charAt(0)}
                </div>
                <h3 className="text-lg font-semibold text-gray-900">{member.name}</h3>
                <p className="text-sm text-indigo-600 mb-2">{member.role}</p>
                <p className="text-sm text-gray-500">{member.bio}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 px-4 sm:px-6 lg:px-8 bg-white text-center">
        <h2 className="text-2xl font-extrabold text-gray-900 mb-4">
          Want to work with us?
        </h2>
        <p className="text-gray-600 mb-6">
          We&apos;re always looking for talented people to join our team.
        </p>
        <Link
          href="/contact"
          className="inline-flex items-center justify-center px-8 py-3 bg-indigo-600 text-white font-semibold rounded-lg hover:bg-indigo-700 transition-colors"
        >
          Get in touch
        </Link>
      </section>

      <Footer />
    </>
  );
}
