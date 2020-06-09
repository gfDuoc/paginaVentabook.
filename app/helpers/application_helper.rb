module ApplicationHelper
  include Pagy::Frontend

  def empty_zero(dato)
    dato = 0   if dato.blank?
    dato
  end

  def date_format(dato,modo='n')
    ret = nil
    if dato.class == Date || dato.class == Time
      ret = dato.strftime("%Y-%m-%d") if modo == 'r' || 'e'
      ret = dato.strftime("%d-%m-%Y") if modo == 'n'
    elsif modo == 'e'
      ret = Time.now.strftime("%Y-%m-%d")
    end
    ret
  end

  def date_string_format(dato,modo)
    ret = nil
    if dato.class == String && dato.present?
      begin
        return ret = ( Time.parse(dato)).strftime("%d-%m-%Y")
      rescue ArgumentError
        return false
      end#validation
    end
    ret
  end

  def to_num(dato)
    ret = 0
    ret = dato.to_i  if dato.present?
  end

  def mesage_satus(num)
    ret = ""
    ret = $order_status[num] if $order_status[num].present?
    ret
  end

  def mesage_color(num)
    ret = ""
    ret = $flash_status[num] if $flash_status[num].present?
    ret
  end

end
