class TransUnitsController < ApplicationController
  def index
    @trans_units = TransUnit.order(trans_unit_id: :desc)
    @today = Date.current
    @updated_today = TransUnit.where("DATE(updated_at) = ?", @today)

    # Recupera l'ultimo import
    @last_import = ImportLog.order(imported_at: :desc).first
  end

  def refresh
    XmlFetcher.call(source: "manual")
    redirect_to root_path, notice: "Dati aggiornati con successo."
  end
end
