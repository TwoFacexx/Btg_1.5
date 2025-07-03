// Desenhar com blend mode aditivo para brilho  
// Draw using additive blend mode for glow  
gpu_set_blendmode(bm_add);
// pt-PT: Define o modo de mistura para aditivo para criar efeito de brilho  
// EN: Sets blend mode to additive to create glow effect

draw_self();
// pt-PT: Desenha a instância atual  
// EN: Draws the current instance

gpu_set_blendmode(bm_normal);
// pt-PT: Restaura o modo de mistura para normal após desenhar  
// EN: Restores blend mode to normal after drawing
