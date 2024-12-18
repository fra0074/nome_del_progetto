require "open-uri"
require "nokogiri"

class XmlFetcher
  URL = "https://www.ea.com/ea-sports-fc/ultimate-team/web-app/content/25E4CDAE-799B-45BE-B257-667FDCDE8044/2025/fut/packs/loc/storepackdescriptions.en_us.xml"

  def self.call
    xml = URI.open(URL).read
    doc = Nokogiri::XML(xml)

    doc.xpath("//trans-unit").each do |node|
      resname = node.attr("resname")
      source = node.at_xpath("source")&.text

      # Estrazione dell'ID dal resname
      if resname
        match_data = resname.match(/\d+/)
        trans_unit_id = match_data ? match_data[0].to_i : "000"
      else
        trans_unit_id = "000"
      end

      # Trova o crea il record in base al resname
      trans_unit = TransUnit.find_or_initialize_by(resname: resname)
      trans_unit.source = source
      trans_unit.trans_unit_id = trans_unit_id
      trans_unit.save!
    end
  end
end
