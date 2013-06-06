function oculta_figs (figuras)
    for contador = 1:length(figuras)
        set(figuras(contador), 'Visible', 'off');
    end
end