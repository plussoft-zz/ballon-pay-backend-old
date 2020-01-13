module PersonUtils

  def abrevia(nome)
    max_char = 13
    arr_nome = nome.split
    len_nome = 0
    abr_nome = ""
    preposicoes = ['do', 'Do', 'DO', 'da', 'Da', 'DA', 'de', 'De', 'DE', 'dos', 'Dos', 'DOS', 'das', 'Das', 'DAS'];
    
    arr_nome.each_with_index do |palavra , i|
        if i == 0 || i == (arr_nome.length() -1)
            abr_nome.concat(" ").concat(palavra)
        else
            unless preposicoes.include?(palavra)
                len_previsto = palavra.length + 1 + len_nome.to_i
                if (len_previsto >= max_char)
                    abr_nome.concat(" ").concat(palavra.split(//)[0])
                else
                    abr_nome.concat(" ").concat(palavra)
                end
            end
        end
        len_nome = abr_nome.length
    end
    
    abr_nome.strip!
  end

  def remove_mask(text)
    return '' unless text.present?
    text.gsub(/[^0-9A-Za-z]/, '')
  end
end
