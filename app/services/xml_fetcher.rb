require "open-uri"
require "nokogiri"

class XmlFetcher
  URL = "https://www.ea.com/ea-sports-fc/ultimate-team/web-app/content/25E4CDAE-799B-45BE-B257-667FDCDE8044/2025/fut/packs/loc/storepackdescriptions.en_us.xml"

  def self.call(source: "automatic")
    xml = URI.open(URL).read
    doc = Nokogiri::XML(xml)

    doc.xpath("//trans-unit").each do |node|
      resname = node.attr("resname")
      source_text = node.at_xpath("source")&.text

      if resname
        match_data = resname.match(/\d+/)
        trans_unit_id = match_data ? match_data[0].to_i : "000"
      else
        trans_unit_id = "000"
      end

      tu = TransUnit.find_or_initialize_by(resname: resname)
      tu.source = source_text
      tu.trans_unit_id = trans_unit_id
      tu.save!
    end

    # Aggiorna ImportLog
    ImportLog.create(imported_at: Time.current, source: source)
  end
end
