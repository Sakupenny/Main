local similar_chars = {
    A = "Ꭺ",
    B = "Ᏼ",
    C = "Ⲙ",
    D = "Ꭰ",
    E = "Ꭼ",
    F = "Ϝ",
    G = "𝒢",
    H = "𝓗",
    I = "𝑖",
    J = "𝒥",
    K = "𝒦",
    L = "𝓛",
    M = "𝓜",
    N = "𝒩",
    O = "𝒪",
    P = "𝒫",
    Q = "𝒬",
    R = "𝑅",
    S = "𝒮",
    T = "𝒯",
    U = "𝒰",
    V = "𝒱",
    W = "𝒲",
    X = "𝒳",
    Y = "𝒴",
    Z = "𝒵"
}

local function encryptStr(text)
    local encrypted_text = ""
    for i = 1, #text do
        local char = text:sub(i, i):upper()
        encrypted_text = encrypted_text .. (similar_chars[char] or char)
    end
    return encrypted_text
end

function renameComponents(c)
  local i
  if c.Component then
    for i=0,c.ComponentCount-1 do
      renameComponents(c.Component[i])
    end
  end

  if c.Caption then
    c.Caption=encryptStr(c.Caption)
  end
end


for i=0,getFormCount()-1 do
    local form = getForm(i)
    for j=0,form.ControlCount-1 do
      renameComponents(form)
    end

    form.Caption=encryptStr(form.Caption)
end

registerFormAddNotification(function(f)
  f.registerCreateCallback(function(frm)
    renameComponents(f)
  end)
end)
