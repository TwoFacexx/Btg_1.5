persistent = true;
// pt-PT: Torna o objeto persistente entre rooms (não é destruído ao mudar de room)  
// EN: Makes the object persistent across rooms (not destroyed when changing rooms)

// Variáveis do menu principal  
// Main menu variables  
pausado = false;  
// pt-PT: Indica se o jogo está pausado  
// EN: Indicates if the game is paused

menu_pausa = ["Continuar", "Opções", "Menu Principal"];  
// pt-PT: Opções disponíveis no menu de pausa  
// EN: Available options in the pause menu

escala_opcoes = [1, 1, 1];  
// pt-PT: Escala (tamanho) das opções do menu para efeitos visuais  
// EN: Scale (size) of menu options for visual effects

// Controle de telas  
// Screen control  
tela_atual = "pause"; // "pause" ou "opcoes"  
// pt-PT: Tela atualmente ativa ("pause" ou "opcoes")  
// EN: Currently active screen ("pause" or "options")

// Variáveis do menu de opções  
// Options menu variables  
opcoes_menu = ["Volume Música", "Volume SFX", "Resolução", "Voltar"];  
// pt-PT: Opções disponíveis no menu de definições  
// EN: Available options in the settings menu

escala_opcoes_menu = [1, 1, 1, 1];  
// pt-PT: Escala das opções do menu de definições para efeitos visuais  
// EN: Scale of settings menu options for visual effects

resolucoes = ["1280x720", "1920x1080", "2560x1440"];  
// pt-PT: Lista de resoluções suportadas  
// EN: List of supported resolutions

resolucao_atual = 1;  
// pt-PT: Índice da resolução atualmente selecionada (1920x1080)  
// EN: Index of the currently selected resolution (1920x1080)

// Variáveis de animação  
// Animation variables  
alpha_fundo = 0;  
// pt-PT: Transparência do fundo do menu  
// EN: Background transparency of the menu

offset_menu = 100;  
// pt-PT: Deslocamento vertical do menu para animação  
// EN: Vertical offset of the menu for animation

surf_pause = -1;  
// pt-PT: Identificador da superfície de pausa (inicializado a -1)  
// EN: Identifier for the pause surface (initialized to -1)

delay_input = 0;  
// pt-PT: Delay para evitar input repetido muito rápido  
// EN: Delay to prevent very fast repeated input

// Variáveis do popup de confirmação  
// Confirmation popup variables  
popup_ativo = false;  
// pt-PT: Indica se o popup está ativo  
// EN: Indicates if the popup is active

popup_alpha = 0;  
// pt-PT: Transparência do popup  
// EN: Popup transparency

popup_y_offset = 50;  
// pt-PT: Deslocamento vertical do popup para animação  
// EN: Vertical offset of the popup for animation

popup_texto = "";  
// pt-PT: Texto mostrado no popup  
// EN: Text displayed in the popup

popup_opcao_selecionada = 0;  
// pt-PT: Índice da opção selecionada no popup  
// EN: Index of the selected option in the popup

popup_escalas = [1, 1];  
// pt-PT: Escala das opções do popup para efeitos visuais  
// EN: Scale of popup options for visual effects
