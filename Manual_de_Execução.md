# ⚡ Manual de Execução
## Super Bogalho: Echoes of the Hat

### 🚀 Executando o Jogo

**Pré-requisitos:**
- Windows 7 ou superior
- DirectX 11 instalado
- ~100MB de espaço livre

**Método 1 - Atalho da Área de Trabalho:**
- Duplo clique no ícone "Super Bogalho" na área de trabalho

**Método 2 - Menu Iniciar:**
- Clique no botão Iniciar
- Procure por "Super Bogalho" ou "Mead Games"
- Clique no jogo para iniciar

**Método 3 - Pasta de Instalação:**
- Navegue até a pasta de instalação
- Execute o arquivo `Super_Bogalho.exe`

### 🎯 Navegação pelos Menus

O jogo possui uma interface de menus intuitiva com as seguintes opções:

**🔄 Continuar** *(aparece apenas se há um save)*
- Carrega o progresso salvo automaticamente
- Leva você diretamente ao último nível jogado

**🆕 Novo Jogo**
- Inicia uma nova aventura do zero
- Se houver save anterior, pergunta se deseja apagar o progresso

**🏆 Conquistas**
- Visualiza todas as conquistas do jogo
- Mostra quais você já desbloqueou e quais ainda faltam

**⚙️ Opções**
- **Volume Música:** Ajusta música de fundo (100% → 0% → 10% → 20%...)
- **Volume SFX:** Ajusta efeitos sonoros (100% → 0% → 10% → 20%...)
- **Resolução:** Alterna entre 1280x720, 1920x1080, 2560x1440

**❌ Sair**
- Fecha o jogo completamente
- O progresso é salvo automaticamente

### 🕹️ Controles Durante o Jogo

**Movimento:**
- **A / D:** Mover o personagem para esquerda/direita
- **Espaço:** Pular
- **W:** Entrar em portas

**Interface:**
- **ESC ou P:** Pausar/Despausar o jogo

**Funções de Debug (durante desenvolvimento):**
- **S:** Salvar jogo manualmente
- **L:** Carregar jogo
- **R:** Resetar save (com confirmação)
- **Enter:** Reiniciar após Game Over (modo manual)

### ⏸️ Menu de Pausa

**Durante o jogo, pressione ESC ou P para abrir o menu de pausa:**

**▶️ Continuar**
- Retorna imediatamente ao jogo

**⚙️ Opções**
- Mesmo menu de opções do menu principal
- Alterações são aplicadas e salvas instantaneamente

**🏠 Menu Principal**
- Volta ao menu inicial
- Pergunta confirmação antes de sair
- Progresso é salvo automaticamente

### 📊 Sistema de Persistência de Dados

**Implementação da Persistência:**
- **Formato:** JSON serializado com encriptação Base64
- **Localização:** `pigplatformer_save.dat` na pasta do jogo
- **Estrutura:** Sistema hierárquico com jogador → estatísticas/conquistas/configurações
- **Segurança:** Verificação de integridade automática ao carregar

**Dados Persistidos:**
- ✅ Progresso de níveis
- ✅ Moedas coletadas (sistema único - não respawnam)
- ✅ Conquistas desbloqueadas
- ✅ Configurações de áudio e vídeo
- ✅ Estatísticas de jogo (porcos mortos, tempo jogado)

**Backup e Recuperação:**
- Save automático a cada 60 segundos
- Validação de dados ao carregar
- Recriação automática se arquivo corrompido

### 🎮 Interface de Jogo (HUD)

**Canto Superior Esquerdo:**
- **💖 Corações:** Mostram suas vidas restantes (máximo 3)
- **🪙 Moedas:** Contador de moedas coletadas na sessão atual

**Durante Game Over:**
- **Modo Manual:** Pressione ENTER para reiniciar
- Efeito de câmera lenta para dramatização

### 🎯 Mecânicas de Jogo

**❤️ Vidas:**
- Você possui 3 vidas por padrão
- Perde vida ao tocar inimigos ou ser atingido por bombas
- Game Over ocorre quando todas as vidas acabam

**🪙 Moedas:**
- Colete moedas espalhadas pelos níveis
- **Sistema persistente**: Moedas coletadas não respawnam
- Progresso é salvo automaticamente
- Use para acompanhar seu progresso

**🐷 Inimigos:**
- **Porcos Básicos:** Caminham aleatoriamente, podem ativar bombas
- **Porcos Bomba:** Detectam o jogador e atiram bombas
- **Pule na cabeça** dos inimigos para derrotá-los
- Cada inimigo eliminado conta para conquistas

**💣 Bombas:**
- **Estados:** Desligada → Acesa → Explosão
- **Reação em cadeia:** Bombas ativam outras bombas próximas
- Podem ser ativadas por inimigos ou por outras explosões
- Causam dano em área

**🏆 Sistema de Conquistas:**
- **"Primeiro Bacon!":** Mate seu primeiro porco
- **"Caçador de Porcos!":** Mate 10 porcos
- **"Explosivo!":** Seja atingido por uma bomba
- Conquistas são salvas permanentemente

### 🎵 Sistema de Áudio Implementado

**Música Ambiente:**
- Tema musical no menu principal
- Controle de volume independente para música
- Reprodução em loop automática

**Efeitos Sonoros (SFX):**
- ✅ Som de passos durante movimento
- ✅ Som de pulo e aterrissagem
- ✅ Som de coleta de moedas
- ✅ Som de explosões de bombas
- ✅ Som de dano/hit nos inimigos
- ✅ Sons de interface (porta abrindo/fechando)

**Controle de Volume:**
- Separação entre música e SFX
- Ajuste em tempo real via menu
- Configurações salvas automaticamente

**🔊 Controle de Volume:**
- **Volume Música:** Controla música de fundo
- **Volume SFX:** Controla efeitos sonoros
- Ajuste vai de 100% → 0% → 10% → 20% → ... → 90% → 100%
- Configurações são salvas automaticamente

### 🖥️ Compatibilidade de Plataformas

**Plataforma Principal:**
- **Windows** (7/8/10/11): Executável nativo `.exe`
- Testado em diferentes resoluções e configurações

**Exportação Adicional:**
- **Linux/macOS**: Compatível via Wine (testado)
- **Outras plataformas**: GameMaker Studio 2 suporta múltiplas plataformas
  
**Limitações Atuais:**
- HTML5: Não recomendado devido ao sistema de save em arquivo
- Mobile: Não implementado (requer adaptação de controles)

### 🛠️ Troubleshooting Durante Execução

**Jogo Travou:**
1. Pressione Alt+Tab para minimizar
2. Feche o jogo pelo Gerenciador de Tarefas
3. Reinicie o jogo - o save automático preservará o progresso

**Som Cortando:**
1. Vá em Opções → ajuste volumes
2. Teste diferentes níveis de volume
3. Reinicie o jogo se necessário

**Controles Não Respondem:**
1. Pressione ESC para pausar/despausar
2. Clique na janela do jogo para garantir foco
3. Reinicie o jogo se o problema persistir

**Performance Baixa:**
1. Reduza a resolução em Opções
2. Feche navegadores e outros programas
3. Verifique se não há atualizações do Windows rodando

### 📝 Créditos e Recursos

**Desenvolvimento:**
- **Desenvolvedor:** Pedro Fontana Moretti
- **Orientadora:** Helena Nunes
- **Instituição:** Escola Profissional Bento de Jesus Caraça
- **Projeto:** FCT/PAP 2025 - Curso GPSI

**Recursos Visuais:**
- **Sprites do Player:** Criados usando Aseprite
- **Sprites dos Inimigos:** Desenvolvimento próprio
- **Sprites de Ambiente:** Criação original
- **Partículas:** Sistema desenvolvido internamente

**Recursos Sonoros:**
- **SFX:** [Especificar fonte dos efeitos sonoros]
- **Música:** [Especificar fonte da música ambiente]
- **Processamento:** Sistema `tocar_som()` desenvolvido internamente

**Tecnologias:**
- **Engine:** GameMaker Studio 2 (2024.x)
- **Linguagem:** GML (GameMaker Language)
- **Controle de Versão:** Git + GitHub
- **Design:** Aseprite para pixel art

### ❌ Encerrando o Jogo

**Métodos para Fechar:**
1. **Menu Principal → Sair**
2. **Alt+F4** durante a execução
3. **X** no canto da janela (se em modo janela)
4. **Ctrl+Alt+Del → Gerenciador de Tarefas** (emergência)

**Importante:** O progresso sempre é salvo automaticamente antes de fechar!

### 📋 Logs de Execução e Debug

**Informações de Debug Disponíveis:**
- `show_debug_message()` para monitoramento de save/load
- Logs de coleta de moedas e conquistas
- Verificação de integridade de dados
- Monitoramento de performance (FPS, memória)

**Comandos de Debug (Desenvolvimento):**
- **S:** Save manual com log
- **L:** Load manual com verificação
- **R:** Reset completo do save
- **T:** Teste manual de conquistas (tela conquistas)
- **I:** Reinicialização forçada do sistema save

**Localização dos Logs:**
- Output console do GameMaker Studio 2
- Mensagens de debug em tempo real durante execução

---

## 📊 Informações Técnicas

**Versão:** 1.5  
**Data de Compilação:** Junho 2025  
**Compatibilidade:** Windows 7+  
**Espaço em Disco:** ~100MB  
**RAM Recomendada:** 4GB+  

Para suporte técnico, consulte o [README.md](README_PT.md) principal.