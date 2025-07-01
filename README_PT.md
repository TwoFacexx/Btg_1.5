## 🧢 Super Bogalho: Echoes of the Hat

> Um jogo de plataformas 2D onde porcos verdes são os principais inimigos e bombas são tanto a sua salvação quanto a sua perdição.

---

### 🎮 Sobre o Jogo
**Super Bogalho: Echoes of the Hat** é um jogo de plataformas 2D desenvolvido no GameMaker Studio 2. O jogador controla Bogalho, um personagem peculiar com a missão de destruir porcos verdes através de saltos e bombas, explorando níveis com perigos, conquistas e desafios visuais.

---

### 🚀 Features
- IA de inimigos com estados variados (andando, parado, pegando bomba, arremessando)
- Sistema de bombas com detonação em cadeia
- Conquistas desbloqueáveis e sistema de pop-ups
- HUD dinâmica com vidas, moedas, e feedback visual
- Partículas para explosões, coleta de moedas e mortes de inimigos
- Save/Load com encriptação em base64 (JSON serializado)
- Exportação para Windows e compatibilidade com Wine/Linux
- Menu com opções visuais e de áudio

---

### 🕹️ Controles (Teclado)
| Ação         | Tecla        |
|--------------|--------------|
| Mover        | A / D        |
| Saltar       | Espaço       |
| Entrar Porta | W            |
| Salvar       | S            |
| Carregar     | L            |
| Reset Save   | R            |

---

### 📁 Persistência de Dados
- Dados salvos em um arquivo local `.dat` (encriptado em Base64)
- Estrutura baseada em JSON: estatísticas, conquistas, configurações e progresso
- Salvamento automático a cada 60 segundos ou ao finalizar nível
- Dados restaurados com `aplicar_dados_carregados()`

Exemplo de estrutura:
```json
{
  "jogador": {
    "estatisticas": {
      "vidas_atuais": 3,
      "moedas_total": 42,
      "porcos_mortos": 15,
      "pontos_record": 8000,
      "mortes_total": 2,
      "nivel_atual": 4,
      "tempo_jogado": 762
    },
    "configuracoes": {
      "volume_master": 0.8,
      "volume_sfx": 0.6,
      "volume_musica": 0.7
    },
    "conquistas": ["primeiro_porco"]
  }
}
```

---

### 🧠 Inteligência Artificial
- Porcos verdes têm comportamentos diferentes:
  - Caminham aleatoriamente
  - Reagem a bombas (pegam ou acendem)
  - Lógica de colisão, dano, e morte
- Porcos com bomba enxergam o jogador e o atacam 

---

### 💣 Sistema de Bombas
- Bombas passam por 3 estados: `off` → `on` → `boom`
- Detonação cria partículas, toca som, causa dano, e ativa bombas vizinhas
- Se o jogador for atingido, desbloqueia a conquista "Explosivo!"

---

### 🏆 Conquistas
| ID             | Nome               | Condição                          |
|----------------|--------------------|------------------------------------|
| primeiro_porco | Primeiro Bacon!    | Matar o primeiro porco             |
| 10_porcos      | Caçador de Porcos! | Matar 10 porcos                    |
| explosivo      | Explosivo!         | Ser atingido por uma bomba         |

Pop-ups visuais são exibidos sempre que uma conquista é desbloqueada.

---

### 🔊 Menu e Configurações
- Tema musical no menu principal
- Volume de música e efeitos ajustável
- Suporte a resoluções: 1280x720, 1920x1080, 2560x1440

---

### 🧪 Testes
- Save/load testado com simulação de corrupção
- Conquistas e estatísticas verificadas com debug visual
- Otimização através de uso leve de instâncias e efeitos

---

### 🖥️ Plataformas
- **Windows**: executável nativo `.exe`
- **Linux/macOS**: compatível via **Wine** (testado)
- **HTML5 / Android**: não suportado diretamente nesta versão

---

### 📜 Licença & Direitos
Este jogo foi criado por Pedro Moretti no âmbito da FCT/PAP 2025. Todos os assets usados foram criados ou licenciados para uso educacional.

---

### 🧩 Requisitos Mínimos
- Windows 7+
- CPU Dual-Core
- 4GB RAM
- DirectX 11
- ~100MB de armazenamento

---

### 🧠 Desenvolvido por
**Pedro Moretti**  
Projeto FCT/PAP - Curso Profissional de TGPSI  
**Mead Games** (label de desenvolvimento)

---

### 📂 GitHub / Código-Fonte
Se pretendes explorar o código ou contribuir:  
[link_para_o_repositório_aqui](https://github.com/teu-repo-aqui)

> Obrigado por jogar ✨