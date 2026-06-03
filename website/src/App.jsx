import { useEffect, useState } from "react";
import heroImage from "./assets/hero.png";

const downloadUrl = "#";

const navLinks = [
  { href: "#about", label: "O Jogo" },
  { href: "#features", label: "Mecânicas" },
  { href: "#gallery", label: "Galeria" },
  { href: "#characters", label: "Personagens" },
];

const featureCards = [
  {
    number: "01",
    label: "◈ ENIGMAS MATEMÁTICOS",
    title: ["A Matemática", "Transforma o Mundo"],
    description:
      "Pontes destruídas, portões travados e mecanismos parados exigem soluções exatas. Cada resposta correta reativa estruturas e libera novas rotas no mapa.",
    tag: "◆ CAMPO PRIMORDIAL",
    imagePosition: "50% 70%",
  },
  {
    number: "02",
    label: "◈ MUNDO ABERTO",
    title: ["Uma Vila.", "Um Mundo a Restaurar."],
    description:
      "A vila central funciona como abrigo, hub narrativo e ponto de progressão. NPCs, missões e comerciantes conectam o jogador a regiões que evoluem com a campanha.",
    tag: "◆ VILA CENTRAL",
    imagePosition: "0% 10%",
    flipped: true,
  },
  {
    number: "03",
    label: "◈ COMBATE LIVRE",
    title: ["Lute Sem", "Pressão Matemática"],
    description:
      "Os combates acontecem em tempo real, com foco em movimento, leitura de padrão e exploração. A matemática entra como ferramenta do mundo, não como punição em batalha.",
    tag: "◆ COMBATE",
    imagePosition: "65% 80%",
  },
];

const galleryItems = [
  {
    title: "Campos em ruína",
    caption: "Exploração em áreas instáveis",
    imagePosition: "center 35%",
  },
  {
    title: "Rotas da vila",
    caption: "Hub central e progressão narrativa",
    imagePosition: "left 18%",
  },
  {
    title: "Estruturas reativadas",
    caption: "Puzzles que alteram o cenário",
    imagePosition: "center 72%",
  },
];

const characters = [
  {
    name: "O Arquiteto",
    role: "◈ PROTAGONISTA",
    bio: "Treinado para ler os Códigos que moldam a realidade. Acorda sem memórias, mas com a capacidade de restaurar o que foi rompido.",
    stats: [
      { label: "FOR", value: 80, color: "#b8901e" },
      { label: "AGI", value: 65, color: "#4e8c4a" },
      { label: "INT", value: 92, color: "#4a90d9" },
    ],
    sprite: <ArchitectSprite />,
  },
  {
    name: "O Mercador",
    role: "◈ NPC · COMERCIANTE",
    bio: "Negocia fragmentos de Códigos desde antes da instabilidade. Sabe mais sobre os Primordiais do que qualquer habitante da vila.",
    stats: [
      { label: "FOR", value: 15, color: "#b8901e" },
      { label: "AGI", value: 42, color: "#4e8c4a" },
      { label: "INT", value: 98, color: "#d9742b" },
    ],
    sprite: <MerchantSprite />,
  },
  {
    name: "???",
    role: "◈ DESCONHECIDO",
    bio: '"Você não deveria ser capaz de ler os Códigos. Ainda assim... estamos aqui, juntos no início."',
    stats: [
      { label: "FOR", value: 0, color: "#b8901e" },
      { label: "AGI", value: 0, color: "#4e8c4a" },
      { label: "INT", value: 0, color: "#4a90d9" },
    ],
    mystery: true,
    sprite: <MysterySprite />,
  },
];

const systemRequirements = [
  { label: "SO", value: "Windows 7 / 10 / 11 (64-bit)" },
  { label: "CPU", value: "Intel Core i3 ou equivalente" },
  { label: "RAM", value: "4 GB" },
  { label: "GPU", value: "OpenGL 3.0 ou superior" },
  { label: "HDD", value: "500 MB disponíveis" },
];

export default function App() {
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const onScroll = () => {
      setScrolled(window.scrollY > 60);
    };

    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  useEffect(() => {
    const revealElements = document.querySelectorAll("[data-reveal]");
    const revealObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("vis");
          }
        });
      },
      { threshold: 0.08, rootMargin: "0px 0px -36px 0px" },
    );

    revealElements.forEach((element) => revealObserver.observe(element));

    const statCards = document.querySelectorAll("[data-character-card]");
    const statObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return;

          entry.target.querySelectorAll("[data-stat]").forEach((stat, index) => {
            window.setTimeout(() => {
              stat.style.width = `${stat.dataset.stat}%`;
            }, index * 140);
          });

          statObserver.unobserve(entry.target);
        });
      },
      { threshold: 0.3 },
    );

    statCards.forEach((card) => statObserver.observe(card));

    return () => {
      revealObserver.disconnect();
      statObserver.disconnect();
    };
  }, []);

  return (
    <div className="page-shell">
      <header className={`nav-shell ${scrolled ? "scrolled" : ""}`}>
        <nav className="nav">
          <a href="#hero" className="nav-wordmark">
            ◈ <em>CÓDIGOS</em> PRIMORDIAIS
          </a>
          <ul className="nav-links">
            {navLinks.map((link) => (
              <li key={link.href}>
                <a href={link.href}>{link.label}</a>
              </li>
            ))}
          </ul>
          <a href="#download" className="nav-cta">
            DOWNLOAD GRÁTIS
          </a>
        </nav>
      </header>

      <main>
        <section id="hero" className="hero">
          <div
            className="hero-bg"
            style={{ backgroundImage: `url(${heroImage})` }}
          />
          <div className="hero-veil" />
          <div className="hero-inner">
            <span className="hero-eyebrow">
              ◆ RPG EDUCATIVO · EM DESENVOLVIMENTO ◆
            </span>
            <h1 className="hero-logo">
              CÓDIGOS
              <br />
              <span className="hl">PRIMORDIAIS</span>
            </h1>
            <p className="hero-sub">Um RPG 2D Indie · Pixel Art · PC Windows</p>
            <p className="hero-tagline">
              O mundo entrou em colapso. Você é o único capaz de restaurá-lo
              <br />
              com raciocínio, matemática e a vontade de descobrir a verdade.
            </p>
            <div className="hero-btns">
              <a href="#download" className="btn btn-primary">
                ▼ DOWNLOAD GRÁTIS
              </a>
              <a href="#about" className="btn btn-secondary">
                ◈ Saiba Mais
              </a>
            </div>
            <div className="hero-chips">
              <span className="chip">⊞ WINDOWS</span>
              <span className="chip">∑ MATEMÁTICA</span>
              <span className="chip">◈ ALPHA 0.1</span>
              <span className="chip">♦ GRÁTIS</span>
            </div>
          </div>
          <div className="scroll-hint" aria-hidden="true">
            <div className="scroll-hint-arrow" />
          </div>
        </section>

        <WaveDivider fill="#f8f3e4" path="M0,20 C240,40 480,0 720,20 C960,40 1200,0 1440,20 L1440,40 L0,40 Z" />

        <Section id="about" background="paper-3">
          <SectionHeading
            eyebrow="◈ SOBRE O JOGO ◈"
            title={["Um Mundo Aguarda", "Seu Conhecimento"]}
          />
          <div className="about-grid">
            <div className="about-body reveal" data-reveal>
              <p>
                O mundo atravessa um período de{" "}
                <strong>instabilidade crescente</strong>. Estruturas deixaram
                de funcionar, caminhos foram interrompidos e regiões inteiras
                ficaram hostis.
              </p>
              <p>
                Você é um <em>Arquiteto do Conhecimento</em>, treinado para
                interpretar padrões e restaurar o que foi quebrado através do{" "}
                <strong>raciocínio matemático</strong>.
              </p>
              <p>
                Parta da vila central, aceite missões e explore campos,
                florestas e ruínas. Cada cálculo correto altera o ambiente e
                aproxima o jogador da verdade sobre os Primordiais.
              </p>
              <div className="about-kpi">
                <Kpi value="RPG" label="GÊNERO" />
                <Kpi value="2D" label="PIXEL ART" />
                <Kpi value="∑" label="MATEMÁTICA" />
                <Kpi value="PC" label="WINDOWS" />
              </div>
            </div>
            <div className="reveal" data-reveal>
              <div className="gold-frame">
                <div className="gold-frame-corner tl" />
                <div className="gold-frame-corner tr" />
                <div className="gold-frame-corner bl" />
                <div className="gold-frame-corner br" />
                <img src={heroImage} alt="Campo Primordial em pixel art" />
              </div>
            </div>
          </div>
        </Section>

        <WaveDivider fill="#dcebe8" path="M0,10 C360,40 720,0 1080,20 C1260,30 1380,10 1440,15 L1440,40 L0,40 Z" />

        <Section id="features" background="sky">
          <SectionHeading
            eyebrow="◈ MECÂNICAS ◈"
            title={["Explore. Calcule.", "Restaure."]}
          />
          <div className="feature-list">
            {featureCards.map((feature) => (
              <article
                key={feature.number}
                className={`feat-block reveal ${feature.flipped ? "flip" : ""}`}
                data-reveal
              >
                <div className="feat-text">
                  <span className="feat-number">{feature.number}</span>
                  <span className="feat-icon-label">{feature.label}</span>
                  <h3 className="feat-title">
                    {feature.title[0]}
                    <br />
                    {feature.title[1]}
                  </h3>
                  <p className="feat-desc">{feature.description}</p>
                </div>
                <div className="feat-img-wrap feat-img">
                  <img
                    src={heroImage}
                    alt={feature.title.join(" ")}
                    style={{ objectPosition: feature.imagePosition }}
                  />
                  <span className="feat-img-tag">{feature.tag}</span>
                </div>
              </article>
            ))}
          </div>
        </Section>

        <WaveDivider fill="#f8f3e4" path="M0,16 C280,40 640,0 980,24 C1180,38 1340,12 1440,18 L1440,40 L0,40 Z" />

        <Section id="gallery" background="paper-3">
          <SectionHeading
            eyebrow="◈ GALERIA ◈"
            title={["Visuals do Mundo", "em Construção"]}
          />
          <div className="gallery-grid">
            {galleryItems.map((item) => (
              <article className="gallery-card reveal" data-reveal key={item.title}>
                <img
                  src={heroImage}
                  alt={item.title}
                  style={{ objectPosition: item.imagePosition }}
                />
                <div className="gallery-copy">
                  <span>{item.title}</span>
                  <p>{item.caption}</p>
                </div>
              </article>
            ))}
          </div>
        </Section>

        <WaveDivider fill="#ebe1c6" path="M0,15 C300,40 700,0 1000,25 C1200,40 1350,10 1440,20 L1440,40 L0,40 Z" />

        <Section id="characters" background="paper-2">
          <SectionHeading
            eyebrow="◈ PERSONAGENS ◈"
            title={["Aliados, Mistérios", "e Inimigos"]}
          />
          <div className="chars-grid">
            {characters.map((character) => (
              <article
                key={character.name}
                className={`char-card reveal ${character.mystery ? "mystery" : ""}`}
                data-reveal
                data-character-card
              >
                <div className="char-sprite-bg">{character.sprite}</div>
                <h3 className="char-name">{character.name}</h3>
                <p className="char-class">{character.role}</p>
                <p className="char-bio">{character.bio}</p>
                <div className="stat-group">
                  {character.stats.map((stat) => (
                    <div className="stat-row" key={stat.label}>
                      <span className="slb">{stat.label}</span>
                      <div className="st">
                        <div
                          className="sf"
                          data-stat={stat.value}
                          style={{ background: stat.color, width: "0%" }}
                        />
                      </div>
                    </div>
                  ))}
                </div>
              </article>
            ))}
          </div>
        </Section>

        <WaveDivider fill="#dcebe8" path="M0,25 C400,0 800,40 1200,15 C1320,8 1400,30 1440,20 L1440,40 L0,40 Z" />

        <section id="download" className="download">
          <div className="dl-glow" />
          <div className="section-inner dl-inner">
            <span className="dl-eyebrow reveal" data-reveal>
              ◆ VERSÃO 0.1 ALPHA · EM DESENVOLVIMENTO ◆
            </span>
            <h2 className="dl-title reveal" data-reveal>
              Pronto para ser um
              <br />
              Arquiteto do Conhecimento?
            </h2>
            <p className="dl-sub reveal" data-reveal>
              Download gratuito · PC Windows · Sem cadastro
            </p>
            <div className="reveal" data-reveal>
              <a href={downloadUrl} className="btn btn-download">
                ▼ DOWNLOAD GRÁTIS
              </a>
            </div>
            <div className="sysreq reveal" data-reveal>
              <p className="sr-hd">◈ REQUISITOS MÍNIMOS ◈</p>
              {systemRequirements.map((item) => (
                <div className="sr-row" key={item.label}>
                  <span className="sr-k">{item.label}</span>
                  <span className="sr-v">{item.value}</span>
                </div>
              ))}
            </div>
          </div>
        </section>
      </main>

      <footer className="footer">
        <span className="ft-brand">◈ CÓDIGOS PRIMORDIAIS</span>
        <p className="ft-copy">
          © 2026 · Jogo indie educativo · Todos os direitos reservados
        </p>
        <div className="ft-links">
          <a href="#">itch.io</a>
          <a href="#">Discord</a>
          <a href="#">Twitter</a>
        </div>
      </footer>
    </div>
  );
}

function Section({ id, background, children }) {
  return (
    <section id={id} className={`section section-${background}`}>
      <div className="section-inner">{children}</div>
    </section>
  );
}

function SectionHeading({ eyebrow, title }) {
  return (
    <div className="section-head reveal" data-reveal>
      <span className="section-label">{eyebrow}</span>
      <h2 className="section-title">
        {title[0]}
        <br />
        {title[1]}
      </h2>
      <div className="section-rule">
        <span />
        <em>◆</em>
        <span />
      </div>
    </div>
  );
}

function Kpi({ value, label }) {
  return (
    <div className="kpi">
      <span className="kpi-v">{value}</span>
      <span className="kpi-l">{label}</span>
    </div>
  );
}

function WaveDivider({ fill, path }) {
  return (
    <svg
      className="wave"
      viewBox="0 0 1440 40"
      preserveAspectRatio="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <path fill={fill} d={path} />
    </svg>
  );
}

function ArchitectSprite() {
  return (
    <svg className="char-sprite" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
      <rect x="5" y="0" width="6" height="2" fill="#7ab8e8" />
      <rect x="4" y="1" width="8" height="5" fill="#4a90d9" />
      <rect x="5" y="2" width="6" height="3" fill="#6aaee0" />
      <rect x="5" y="3" width="2" height="1" fill="#0a1628" />
      <rect x="9" y="3" width="2" height="1" fill="#0a1628" />
      <rect x="4" y="6" width="8" height="5" fill="#2a70b9" />
      <rect x="5" y="6" width="6" height="1" fill="#4a90d9" />
      <rect x="2" y="6" width="2" height="2" fill="#4a90d9" />
      <rect x="12" y="6" width="2" height="2" fill="#4a90d9" />
      <rect x="2" y="8" width="2" height="3" fill="#3a80c9" />
      <rect x="12" y="8" width="2" height="3" fill="#3a80c9" />
      <rect x="14" y="3" width="1" height="8" fill="#b8901e" />
      <rect x="13" y="8" width="3" height="1" fill="#97740f" />
      <rect x="5" y="11" width="3" height="3" fill="#1a5099" />
      <rect x="8" y="11" width="3" height="3" fill="#1a5099" />
      <rect x="4" y="14" width="4" height="2" fill="#0a3069" />
      <rect x="8" y="14" width="4" height="2" fill="#0a3069" />
    </svg>
  );
}

function MerchantSprite() {
  return (
    <svg className="char-sprite" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
      <rect x="4" y="0" width="8" height="7" fill="#e0e8f0" />
      <rect x="5" y="1" width="6" height="5" fill="#f0f8ff" />
      <rect x="3" y="2" width="10" height="4" fill="#e8f0f8" />
      <rect x="5" y="2" width="2" height="2" fill="#1a1a3a" />
      <rect x="9" y="2" width="2" height="2" fill="#1a1a3a" />
      <rect x="7" y="4" width="2" height="1" fill="#c8d0e0" />
      <rect x="5" y="6" width="6" height="2" fill="#d0d8e8" />
      <rect x="5" y="7" width="1" height="1" fill="#a0a8b8" />
      <rect x="7" y="7" width="1" height="1" fill="#a0a8b8" />
      <rect x="9" y="7" width="1" height="1" fill="#a0a8b8" />
      <rect x="3" y="0" width="2" height="4" fill="#8a6a1e" />
      <rect x="11" y="0" width="2" height="4" fill="#8a6a1e" />
      <rect x="3" y="6" width="10" height="2" fill="#a8841c" />
      <rect x="3" y="8" width="10" height="5" fill="#7a6010" />
      <rect x="2" y="9" width="2" height="4" fill="#8a6a1e" />
      <rect x="12" y="9" width="2" height="4" fill="#8a6a1e" />
      <rect x="7" y="10" width="2" height="1" fill="#e8c84a" />
      <rect x="5" y="13" width="2" height="2" fill="#5a4408" />
      <rect x="9" y="13" width="2" height="2" fill="#5a4408" />
    </svg>
  );
}

function MysterySprite() {
  return (
    <svg className="char-sprite" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
      <rect x="5" y="0" width="6" height="16" fill="#6a6048" />
      <rect x="3" y="2" width="10" height="12" fill="#6a6048" />
      <rect x="2" y="4" width="12" height="8" fill="#6a6048" />
      <rect x="6" y="3" width="4" height="1" fill="#b8901e" />
      <rect x="9" y="4" width="1" height="3" fill="#b8901e" />
      <rect x="7" y="6" width="2" height="1" fill="#b8901e" />
      <rect x="7" y="8" width="1" height="2" fill="#b8901e" />
      <rect x="7" y="11" width="1" height="1" fill="#b8901e" />
    </svg>
  );
}
