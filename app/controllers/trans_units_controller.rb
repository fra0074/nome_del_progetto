class TransUnitsController < ApplicationController
  def index
    # Ordina i TransUnit per trans_unit_id in ordine decrescente e li raggruppa per trans_unit_id
    all_units = TransUnit.order(trans_unit_id: :desc)
    @groups = all_units.group_by(&:trans_unit_id)

    @today = Date.current
    @updated_today = TransUnit.where("DATE(updated_at) = ?", @today)
  end

  def refresh
    XmlFetcher.call
    redirect_to root_path, notice: "Dati aggiornati con successo."
  end
end
