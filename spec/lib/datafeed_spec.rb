# encoding: utf-8

require 'spec_helper'

describe FoxySync::Datafeed do

  let :datafeed do
    mock = double 'datafeed'
    mock.class.send :include, FoxySync::Datafeed
    mock
  end

  let(:result) { datafeed.datafeed_unwrap({ 'FoxyData' => ENCODED_ENCRYPTED }) }


  context 'datafeed request' do
    it 'should give an ::Api::Response' do
      result.should be_a FoxySync::Api::Response
    end


    it 'should produce a decoded and decrypted XML' do
      doc = Nokogiri::XML(DECODED_DECRYPTED) {|config| config.strict.nonet }

      %w(
        processor_response
        customer_first_name
        customer_last_name
        customer_password
        customer_password_salt
        customer_email
        customer_country
      ).each do |elem|
        result.send(elem).should == doc.xpath("//#{elem}").inner_text
      end
    end
  end


  it 'should give the response text expected by FoxyCart' do
    datafeed.datafeed_response.should == 'foxy'
  end


  ENCODED_ENCRYPTED = "%0E%EEv%04%DB%0B%C5%96%28%C1%D6%B0%BF%07%16E%DCA%CF%FB%C5%ABnIg%9A%FAF%0Bse%60%EA%D4%B2%00%11h%10%A4%A8%EEF-%D7%5C8D%F2L%12VSe7%05%AB%19%E8D%BB%B7%DE%B7%A3%E4%E4%ED%F40j%1C%9AO%FAd%EB%29%8AF%0CDye%5B%8E%DE%1E%82%2C%1B%5Db%D6%3C%80%A4%AC%ADr%8AJ%A1%A9%80+%AC%D8%19%C1%96%1C%B3%1AL%AB%DB%F0Y%B7%AA%0F%E3%D3%E4s%D3%C6W%85%DAeJ%F9%AC%884q%91%EEB%FB%9Aa8S%85HUs%85%C0%8C%0E%E7%A9%7E%C9U%FD%8C%89%EB%87%3FI%B9%A3%0A%DA%9A%1B%0Fq%7D%DD%F2%B6%07%21a%7E%BC%C6m%22v%15X%21%F2Wq7%F9%B6%13jt%0Ah%E4%A6%21%9D%F8Ca%F6%9Ch%98%2C%2B%E3X%89T8L%28%F4%17%FC%B7%A4+%A2R%8F%BB%81sH%23%89%EB%91%87%FA%00%231%F6%17%AF%2B%8D%CE%AD%B7%18%01%ADky%B8%C3%96%04%E2%09%AF%A3%B0S%E9%99%C2O%25D%17%7D%BE%DE%C1%222%16%A8%83b%F6%03%DAxwB%E7U%BF%B1%89%DCL5%C1%EF%9C%F6%16%C7%C0%16W%8E%D0%80%3E%7B%87%14%11%A2e%16%EF%0D%BBm%98%EA%82%D9%E6%C8%F0y%2B%22%F8%5E%7E%84%C4%EC%A3%9Cbm%3D%05k%1A%1A%F9V38%E3%DC%13%91%84A%0F%E1%E3.U%EB%CC%D92%91Q%AD%29%86%99%7F%FD%AC%CF%BE%24P%1D%971%8B%13%1B%3B%8F%0F%A1%FC%ADd%86%FB%0D%85%2B%BA%B4%CF%0DZ%EE%A6%D3m%F0%C7%C79%7C%F4%C1%5CS%3E%10%87%9D%1D%D5%86%B6%29%E9%A77%3F%0DL%15pTm%BA%1Ar-Os%9Cm%EFp%E9%03Y9G%ADE%E4%1ED%FFP%25%CF%DD%DD%F9%D5%D6%8Ai%D1Ls%CEl%7F%E5%AD%09%FA9%3DF%FFw%1C0%F7%E3%B2I%8E%C2%D9%D5z%2C%F2%3A%23%B5%5E%85%E9%DFW%CD%25I%C1%9B%5E%0C%13%90%A6%C1%E2%AE%7F%E1%9F%02%B9%B3%D2cy%7E%D4%2Ar%AD5%AC%F5s%5E%BF%9B%17%0F%7C%01%16%27qs%1FA%D29P%28%BD%C3%85a%AE%80%E3%B5%9F%80%1AI%97k%81%87%F4%C7%C8x%C2%8F%CCj%92%9A8%D0b%91g%E6%FE%5D%86t%C6RK%17f%CB%B2%E1%28%DD%87%CE%25%5E%94%16%ED%5B%C2o%A9%D2%3C%21h%3F0%99d%1A%07%EA%A1%FC%00N%A1%EB%C1u%A53%03%BDM%A2%A5%24%BAo%FF%BBI%BB%CC%A0%E94r%8BQ2%92X%8E%93Zi%FB%CF%7Dt%24%F7%B4%B4%2B%B2%D5D%EA%10%3E%D2%99y%99%5E%1C%3A%ED%E2_%A4%D6%CF%D2%D7%C1%03%7F%94%1C%EE%2C%1A%9C%7D%F8%DBG%17VD%9B%D5%DC%EF0%F57%D0z-%40%BB%9ASI%92%91%C71%D2%CE%16%C8nh1%BD%D4V%FC%9D%AC7v%04%24%B5%D4qw%C8%A3%B9%DE%2C%DB%7D%AD%DC%AFV%40%5C%D2%B3%F7%8F%06-%8D%91%1D%13B%B4%EF%86%3F%D8%25%80%60WY%A2%17%26%FE%E4%02%7E%21%22h%E0o%ED%A9%23%FDTz%01%C4%EF%B9%B0%CE0%5E%2A%3D%C1N%E0%C7%A6%2B%9E%D3%85%12%7C%9B%0Fh%AC%CB%956%A7G%0D%3E%82%E8%91%EE%CE%7D%E2%AC%80%FB%B0%E5%A7%BB7%AD%D5%BD%26%D5%7D%9A%854%3A%F6N4%29%29%8E%ECE%C2%DD%906%EE%C0%60%18%E8k%D5%DC%1BwF%14y%7F%7B%0E%E1%16%E8%16%A4%9D%EE%CA%9BB%939s%B6%CC%D95%0B%90%A8%253%5D%D5%97n%9Ev%CB%F6J%2A%DC%B0%FD%F0%D4%C5%E1%F1%2FZS%05%A9%81%CB%DC-%A6%E3iq%80x%AE%DD%60_%90%ECei%15p%7E%D3vR%D6%D5%EE%A5%7D%13%87%B2Wn%B6D%8FU%ACb%AE%CF%13K%F7%0D%EAZ%C6%D6%DBE%D2%A1%0B%9Fn%A5J%9CH%08A%E5%FD%5B%EC%07%C7%DB%60%24%89%F8B%8E%15%D4%0D%17F%0C%7F%86%EEg%98%07%F5%DA%CD%F1%DC%A9%F6%3B%14%B5%EA%11%FB07p%A1f%1B%FEe%E3%86%94U%B8%8E%0ApH%12%06%1F%C7Rq%CDy%CCs%12%B6%EAX%CD%EF%80S%8D%CB%3D%7F%F3%A6%B6%B0%F3%CFK%24UO%DCq%CE%95%BFt%AF%CC%25%98%F5%2C%EC%24%84%F0%85%E1%C4%D6%EE%C3%96f%98%C3%B0m3a%A1%FE%9C%C5%A5S%C9%A2%05%E6%12%01%0F%B5w%12%EC5%17%83O%A3%E5%17f%C2%D942%82%99%013%5B%A7to%A5j%05%A6%02%87%F1%0AC%5D%A2Y%F5Y%A7%3D%F18%01%3Ar%E1fe0C6%B7%EF%1B%D1X89%9B%18E%ECXw%1C%FC%81%FA%C8%7B%1A%CB%C3%09%E4%C5X%BA%29%DD_%40.%F8%B6%28%1Au%ECgyr%7C%9B%269%0C%B0%7E0.G8%BCQ%85%D7Dh%3C%04%8D%D7+-%85%D9%27%F19%C7%CAIy%CD%26%D6ZM%F8%8E%22%C2%04%C9l%BF%16%A8%C9%A6%EC%B7%AA%14%06%27%FFV%24a%C7%83+c%82%FC%AE%11.%D4%E8%EB%D3%08_%15%A1%08%C7%D2%8A%9A-%40GO%CF%15E%27y%85%C9%8C%21%BE%90%94N%16%05%E2vH%94G%7F%C4l%F2%275.%17%95%AF%FC%AF0%BAV%08%5C6%FD%29%5E%F5%2B%A7%CA%93p%8CG%5CM%E3%BBL%B0%89%A1%DD%B7%94%B7I%3F4%B5T%DB%01%EF%0Bb%CE%D3%EAY%CB%EE%C3%1D8%DA%E4%8B%21%E5%DA%CF571%DD%CF%2F%C7%99%96%EA%E1%F5qp%81%3F4KQ%27%E6%B3%5C%83%EC%FBM%15%FA%094C%80%1F%3F%0Dw%98%CE%B7%05%22%14SB%8D%16KTWK%CC%3F%21%05%CD%06%E9%1A%E59%02%7C%7E%22%8F%BC%B7%16%CC%27%3E%EC%1EV%10%26K44%89%D4%0E%E3%8E%D5%02%E8+g%10%08%92%EB8%BA%FAZ%CC%A8%FEp%B2%A4D%40r%C7%3EQ%01%C9%3B%3F%F2%BF%C7%25%AB%C2gU%02%2C%A3%AB%AA%FC4i%02%EB%8A%26%8A2u%8Ak%A4%24%CA%94%7E%FA%C7%85%C7C%094%C6%26%5DT%C6B%7C9u%FB%FE%97%E8%B8%1C%8EuY%ABm%8E%C9%B3%0C%5C%08S%F1i%F0%3AX%1Ax%05%B9%DE%1A%27I%14jt%B3%8DN%B8%A3%B3w%0B%F4%0Dfd%EC%3E%9Ea%B2%EF%03%0F%3El%9A47I%ED%A2%15%88h%EB%FE%07%A7%B6%5B%E7%CC%FE%DA%02%BE%EF%E6%9B%F5y%1D%3E%ECo%FA%AEh%3B4s%15G.%7D%85%A3%FEM%D2I%E4_%EDG%93%A19%BE%B0%B6%24%14wJt%F6X%A4%9E%26%FA%1C%9B%B3+DU%0EY%1E%AA%5E%15%8D%01%C5J%BFja%C2%FB%16%21%0Aq%97-%90%0ED%1E%25%AF%1Bj%BC%3D%F7%0Ba%7F%84%10%A5%9F%DBe%2FF9%DB%FB%83%D3%05%129%F5%D1_p%3Cp%E1%FEl6%1A%CC%D0a%F2%BA%86%2B%ADh%EC%9D%9BQB_%9B%9A%A5k%B2%C7%03E%29j%AC%CF%9F%17%9D%A4e%23%AD%FD.%23_I%B1%B1JSg%B7-y%110%83%BF7oC1%B0%05A%CC%97%1F%EA%CA%5C%FB%86%B9L%A0%EDu%A0%01%E7%97o%08%ACQqs%D0%3F%E2%80H%BB%7E%CF%16%97%8E%DCG%18f%B4x%D4v%FA%F4p%0C%2F%5B%FA%DB%0E%10%9E%9D%95%5C%B3%0B%1C%5CS%8B%09k%82%B2%D4%A9%C5%A7%E7%0E8%FD%92%EC%01%A0%8F%DEL%15%A4%E3%E7B%90%F0%7F%D6q%1B%DC9%ADB%DD%E2%F7%E43%06%F9gi%13%C7%279%40%E5yt%FD%AB%9D9%CA-U%86%B2%BC%80%B2%C3%CAc+%B33%B8l%F9DP%94%BEI%E9hiZ%C0%5E%24%17%3E%FD%CA9%E5L%C4%7C%F3M%86%98b%80%C2d%29%EE%D9g_G%A1m%F6%BE%F2N%EF%1D%D1Q%C10%9E%5B%F4%13%A3%9EB%25%FE%FD%A8w%EF%7B%B0%7D%8E%DFY%C9a%AEP_Kk%83%B4%82%88%9AJ%A1%5C%C3%8B%E7L%D5%002o%F8%EBb%2B%CD%F5%111%BF%89%DC%99%16%B9%AER%00%A1%CD%D6%B5%5B%CC%D1%17%A96%B8%02%D2-%27v%E5%7D%FC%C1%11l%EE%A8D%A7%E8%CAA%88H%10%CF%A0%F6%FFE%A79G%C1%80c%21%B1%AE%BCf%A3%15%D0%95%1D%FC%7E7%EC%CE%29%09%84e%0F%D5%C7%5B%CC%D1%A6Z%25%60%EFmc%C1BP%D6%DC%EC%85%8FC%5B%08%09Q%5B%7F%B6%1C%24%F9%A6%0D%B7R+65%13xjQ%D4%CC%C6%CF%B3%11%9B%E5%D4l%7DM%DBZ%11%DC%9E%F2%98%D0%0A%EC%ABr%8EGe%0C%D3%7F%24+%97d%90%2B%C0%C9%D3%7D%C7%EB%7B%C7%08Fi.%DF%E2%DDhz%C2%CB%F2%BC%40%27%80%D1%DD%B9b%B3y99%AB-E%AE%D8%E9%2AZ%CD%7FrT%83k%13s%DFt%1B%ED%09%2B%11%B2%1B%EFG%CFZ%CD%9E%7F%A5%AE%A9%5C%F8%1DS%D1%0D%A7%D8%06%9D%A5%F7lN%0C%F1%3E%16BP%99%CDuP%3E%AF%14j%DF%E0T%7E%B31%AEY%AC%AF%86%CDJ%DF%BE%E0%84%40%13%D5%04%8C%94%B9%C0%1EAz%D2%7E_M%B7%3A%E1%AF%ED%EC%24%FD%84R6%CE%04%F9c%EF%82%A6l%40%D1%C2DV%FE%CA%9BA%7D%EACBg%5D%94x%B6%95%40M%D5%E3%E7%84%81%D4-%3E%9C%DB%D7%E7%AA%AA%E3%1C%A3%B7%C6%BE%F9%19%AB%154%15q%C4%01%11%2F%7E5B%D8%F5%14K%89%E82%DF%C9%18%0A%F8b%81h%AF%E2%AB%17%AE%23%DC2L%AB%06%88%95A%15%ACD%90K%8E8K_%602%8E%28%24%230%CDO%C0%60%28%FE%B9Y%E3F%EA%16l%D7%E66p%06%3De%BB%DA%22%00%E7H%40DC%3B%9B%95%21%0C%10%9FPD%25%F0%E5a%DD%BA%EB%CE%FF%E6%BD%8F%CE%DEo%87%ED%16%EAL%FFR%97%EF%3F%AD%C5M%8F_G%0C%C4%27%C1G%3C%02%60%E2%F9%B2%1B%DA%90%FE%CD%1B%D6%7C%24%29%ED%E8%E7%1B%DC%17_%BE%2B%19%D2%14%5EUi%19%C4%CE3l-C%8B%F0%BD%B7v%EF%8AJ%1A%CE%16%F1H%8C0%2C%0Cci+%9E%EC%9C%BEW%AD%C2%11%83a%9E%93K%B5%27%9De%3D%C5%8C%BE%1Cd%7E%CC%F2%F1%99%CD%3C%C6%99aGd%94%12%DB%0E%12%C7%0FD%F8%09L%0C%FF%DDgR%F5%FCq%D8%DB%5E%1B%0A%A8_D%1A%8B%93%B1%D11%CF%D0%E5%14%EBih%99%7Dv7%FE%FB%23%FA%C8%AA%7D%212%FA+e%A1%E5Y%D2%F4%84%15%96%E4y%03t1%86w%7D%89%E2%15B%C1%BE%18%09%AF%B0%B9%C7%BEkp1%AAJ%2F%E0H2%A77%2By%C9%D3%05%0E%E8D%B9%24%DE%F0G%29%956X%2F%03%0F%AD%B48u%C4%C7F%90%AF%B2%17%C0%86%3F%EE%B3c%DDb-w%60%05%C3%91%11%E6%E5V%80gQzmVK%1A%F4%C9u%FF%01%22%3E%29v%0D%A0%8D%F4%B3%0D%1Ak%A15%EF%B6%AA%C5Lb%F0%91%EE%C1%F7X%88%3D%A01%AB%95l%88%01%C6%7C%FE%D7b%8F%87%CA%97%FFg%92%ACS%A5%AC%CC%7E%D7%60t%60%C8%FDp%9B%DB%8B%8F%A5%D4%AA%DF%CB%81%AD%3Dbdr%CD%88%F6E%AEL%09%21%A7%B9%2AO%D1%0E+%10%DD%8An%CC%C2%A7%05F%5B%99%B2%A7g%88%8A%C0%A9%1B%04%9F%3E%3A%AE%CA%E3p%2C_%860%16%9B%E9l%7B%E91%CAVa%1D%DDu9%BA%0FQ%C5q%BA%81%F32h%AD%DC%E0%23%8D%98%1DY%CCU%26%CA%3A%8B%DE%0B%8E%EB%12%D8%2Bo%7D%04%F9-%99%F9i%03%27%04%B5%5CP%C9%93%F1%F6N%95%D6%C3%5E%12%F7I68%C05%A2%A6wl%BC%3A%14%E4X%E6%85%EB%99%CA%26%AC%03%92%E9%D62%94%1BC%0Ap%60%EAeA%A6%04%C5%0F%8Ai%12r%B74%10%E2%D9%08%ADKPq%B8%C1%A3%F9%E3%06%AA%D73%EEVO%3A%26+l%A4%5D%98%A1%21%C4%A6%7D%DA%CD%95V%5E%08%15%CCIk.%E0%8C%89%91S%F5%EA%B5%F1H%B0%2A%8F%96%8F%BF%D1%D8%24%80%0F%CD%C6%5C%0C%83cG%CA%8C%D1%C3%C2%22%82%F7%09%05%A8%15%DCP%2C%B5%B7%801%8E%1C%81%A8%9D%17%848%03%F9%11%07%C2%FC%1E%A2%F8%2B%A6%7F%BE%B4%3D%06%F2%28%8Dfpg%B0%0D%D1%CC%15%BF%A4%BC%B0Zx%9D%E9%11%DE%D3%B4Z%C4o%CE%AB4%BB%D4sK%04%83%C24%C35N%1A%E3%E0XuS%8F%E4%91%FC1%01%A4%F8V%D7%1D%40%1C%0D%93%2BY%FF%88%C9%AFP%7B%8A%D5v%08%97%1C%7E%AE%B1%B6%F3o%FB%E7%C0k%98%21S%83%91%C3%C3%F7%FD%A0%F26%D2%CCZ%AA%18%A6%02%1D%06%0F%5E%BA%0C%DCjt%A4O%E3%9AL%1C%81b%2A%C0%25%3A%9C%A3q%FBL%A1%DB%DF%1D%AE%2F%22%A6%9A%05%A5%EAB%14n%C6%F7N%C6%CC%9F%24%7F%C2%B5%2F%B8o1%1B%A7%C5%3B%EE%F1Qu%E3T%93I%3DT%BE%C8%29%5B%C1%96%2C%1F%28L%F2%C1%7F%AC%000%D4%C7%C1%8B%B1tJ%C7a%B7%01%EE%B8%84%B2%C2%B9%83%A1%60%2C%FA%A2%A51%96%FB%FE%9E%8A%C6%5DB%E8%D7%5CA%9F%C4A%A5%B9%F6%FB%92%9D%97%85%F4%A6%E9%D8K%E2%D70%9F%D6%A6%2CN%AA5k%14%E2%B7%BA%96%D7%FD%DDN%22%275%DD%9C6%85%D8y%9Ck7%5E%24%60%BB7%10%87P%FF%2C%08%FB%BB3%5EO%E3%B7%FF53%D1%97%B8%BD%91Wop%8E%5D%00%F9%24I%12%1A%EC%06O%B4%BFf%7E%FA%B11S%BB%C7%3CEh%B5%00%16%D51%D3%9DD%F1lC%15%7D%2A%A9%E4%A9%A3%12%85%10%D5%03%11%2F%5Ez_%2F%AD%A04%23%DE%FAX%D4q3%18%14%27%DC%DA%87Y%ECT%89%A0%02%BE%CA%8D%AF%14%0B%07%C5%168%BE%99%21%82jP%A6%82%01%7E%AEK%CD%BF%7Cl%03%EC%40%E4%C7%D5s%A5b%60M%2AEN%A2%A6%15T%7C%11%95%07y%AA%3B%D5%D2.C%8F4%8De%25%02%90%AD%2B%2F%D9%EClEu%07%0FF%93X7%9F%40%8E%C9%2F%99b0%CB%85D%18%1F%E5%DCQ%17%11%8A%97N%E4h%91%A6%9D%1C%B6P%AB%BEB%A8%9APP%15%BF%82+%C5%D2%B4%E3%0C%A4z%88%C6%85%0C%E4%1B7%C3%9AZO%FE%19P%849S%0Co%B6f%C4%E8%C0z%A4%DE%98%8C%D6%F0%3C%B6%A9%EAx%0E%0C%FF%E6%FC%84%12%BF%3AU%FC%A7%FC%EEs%27%9E%94%A0%E0n%16a%86%995%A3%CA%0E%FEJi%23%02%C5-%3E0v%D7Q%ED%E8%C5%7B%C8%95%9A.%09okFI%5C%3B%23%A4_10%A8%C8_%DCwX%E1%A4%B1%E5%DA%D3%C5%E1%C8%95lM%7B%1C%A75%1C.4%86%5B%8Fz%BBY%00%0E%2C%3E%ABs%5D%92v2%F1S%E2%E7%EC%BEv%5D%05%F8Gb3Y%15%F5%993j%FD%CA%F4%7Cj%B0%89%B1%C9%12%BA%F6%29%F7%80%F8%9F%CE%CDF%3FM%05Ql%B4zNi%F1%02%F7%9D%3Ea%E7%28x%9E%93%AB%0B%2F%9D%8E%DF%CC%3E%E0%02%A86%3F%D9%D85F%E9%27%9F%CA%19yN4%A4%B4%DE%0C%7F%E6%05%88%B0g%BE532%0B%F4u%F0h%DC%B4%8B%E5%04%F5%82%CB%40%B3x%BE%2C%8A%08%8F%10%97%FF%AA%93w%D0%E55%7E%9F%A1%F5M%9B%ECd%94%09_%01%0B82%E7%E7%0C%C7%C4%24W%A7%12%E3%E2B%9F%FABX%ED%7Fv%2F%BEvX%92Q%89%07%D6%26%2C%0E%18%C1AI%FB%04v%1F%86%FE%BAQ%8B%10%93%D1%28%A1%D1QR%B5%21%06%8F%1DI%C6%D2%40%2Fs%A7%FB%EE%CC%B2%FA%A6%E7n8X%0C%9BV%CA%3BhI%08n%1D%AA%12%D3%96%85%BC%88%AF%C8%FD%F6%2C%1F%2F%24%B4o%11%7C%FB%D1W%C0Z1%86%E4+%04%A3%E3%7C%D36%92%15.%22L%D4%DCGu%E5h%09%99%96%E8%9A%80g%86%07%FD%C5%86RC%FD%03%D3%83.%95Z%02%28%7F%900+FZ%99%9C%EB%8A%8B%E9%26%F11%FB%5E%FBY%BA%97w%B2%80%96%BF%3B%C3%FF%FA%B6%F6%5C%DAh%29%AC%14r%CD%C3%DB1U%1DF%08%B7rX%FEH%9F%A9Z5%BC%9EJ%0Du8%3F%B1%A7%E3J%09%92%7F%DE%BC%D9%98%7C%1A%0F%D2%E8c%C0%F8%BB.4%D5woV%B7%A7%82%CE%D5%DBl%1A%8B%2A%EC%C2%EF%BDNG%96%0D%E8%B4%05%AC7%86%AA%D5%B5+%AD%E2%02%E5%24%AB%0CW-%BA3Y%DB%A7%40%10%D9%24%B5C%A6%D1%1A%BE%06%F3H%82%E22%BB%C8b%A0%E1%DC%D0%CC%1D%3E%18%9F%BDW%3A%25%16%9B%81%0C%81%D0%27%83%5C%A3n%90%0D%F5%C8i%865%95%7C%A0o%BF%FC+n0%3C%F9%2C%8CX%02%14%0AoD%13%A2%E9%9F%1D%21%A0%F9%CD%EC%9B-%90%A1%DF%EF%05%1A0%8A%FA%80l+%14%B5i%F6%21%D0%84ao%FD%60%BCB%1E3%FB%82%B8%9A%B2%1D%D8%F3qd%E4%A8uV%E1%C3%C9%C7%0E%99Z_g2%E1c%DC%FA%A7%92b87%B8%5CB%A0r%21%C0%B4C%D9%93%7D%FD%86d%A1%23%CA%E0%C9x%BFo%2F%18%B7%DB%AC%F9%1D%F2%EC%E5%91sM%BBk%93%DD%5E%BC%A1%7D%7FB%D4%3B%B1%12Wa%E0%B8Q%C7%ED%B9%A9%DEl%B6%7Cd%01%40%21%1B%5BK%C3%0DY%A2%D6%22%C6%8D%DDGx%23%3AS%E2%06%DF%BF%16%C7%C7%07%A9%3Aj%C2%C6KT%D4%EA%F7%F7%C7%18%F1%F5%DA%CA.%3E%BD%E9%7E8%5Ec2%DEd%B8%86%DB%E5%C3%14x%27%CF%8Ce%C1q%14%E0J%DEh%60%87O%BF%1DSTA%AC%AE%B7%AE%07%D7w%E7%F1G%0F%F0Y%92%7B%D4E%CA%F4%AF%5C%9B%FE%8F%B7%5D%E43z%DB%7B%8C%27%FBwj%1AN%BF%EF%F8%60mV%9FH0Q%96%F7%931%AB3r%EF%12%D5%B7%A3%E31%F2%0F%A8%EF%84%00H%2B%25X%12%3A%A5%FD%09%E6%90%D5%88%0BZx%5C%8B%DBb%A2%B39%19_%C5%E4%CF%7EI%3Fa%F2%C9Jb%F0%24%9A%929zL%B1%0B%A9%AB%D7w%C5%C4%FC%1C%3E%16d%F8%C8%A9%FE%DEzAvq%5Ch%08%06%7F%E5e%29%1B%B1%B77%EE%A0%D7%1F%7F%87%A55%F8%18%AB%13%04W_%2C%2F%9CP%D2v%B0%5E%B7%F0%97j%7D%3BF%B73%DB%F3%F8S%E3%97%7E%0D%03n%26L%8D%9EF%9B_%E0%2AVY%F00%BC%D9%04%D5%FAi%7CL%F5_%C6J%16l%9D%98%DCXs%F0%B4g%3Exr%1B%82%13%1B%B1%29K%1E%C9%AA9y%F6aOK%F52%85%F0%81%7F%9F%93%25%FA%3E%3D%B7%94%A1%D1j%F4%BB%80%F5%95%01%11u%2A%9CdV%C5%DD%DB%5D%94PYj%D6%C3%7B%1C%28%962%8A%FBh%AD%AEk%3E%11X%F4Q%D6%CA%08%99h%BBe%A8%251%F3B%3Au%E5%AE%01hR%CDV%26%F4%A2%88%CF%FB%11%17%0A%7F%ED%7E%3E%F9%3FPbB%E6%1D%96%18%C4N%B1n.%F2R%3A%CA%C6%3E%C3%E3%C4%B1%2A%F0%3B%B5W%0C%E2%3A%D5V0%A3%C5%A4%81%CB%85%E6Re%C8%B8%16b%05%93%13%85%FFr%E2%91%FB%E1R%98%03%FF%D7%10%26%03%B2%CC%E1%D1%BA%09%BA%1B%F1%ED%EFH%B7%DFf%B8lU%88%9E%AA%C3h-%03cK%B8%27Z%846n%3F%F3QI%87%C2%87%A2%AAg%E0%99%8D%E9%21%1B%28v%10%1E%3E%5E%0D%19%C9%A4%0EM_D%87vUG-%09%1C%1B%E9%3D%29%E8K%01%FA%C8%AB%F3%A54%C9%2A%9A%E5%CC%BBN%C7%AB%3C5%EDF%9BY%19%90AXc%1D%AD%3A%D7L%C1Tr%C7%DF%2C%26Wg%A4p%98%2Fy%FAo%D4%DC%FD%1E%C2.%3C1%2B%12%1D%B1%DB%DFvd%85%0E%8B%9E%9B%BD%A9%8F%B2Q%3C%E8%7F9C%0B5%F4%7E%3Ez%04%04e%F4E%24%AD%B3%AF%EASy%24%C7%A3%8D%1F%0BJ%1B%8C%C8%F3%CCm%B6%F8%ED%CCE%B9%88%C2%AFV%1B%EB%F8%5E%C5%E2%86%ABqx%22%80%EC%A7%A6%B6%12%89%D05%AC%DBZ%EE%FB%9C%DE7%0B%8B%A1Q%1E%00%F4%BD%F8%051%22%ED%0B%14%82%83%A7%A3%11%A2Q%E6%89k%81%9Ef%E0i%EB%19%07%2B%03%144%EF%D7%96%F4%2B%94%AD%F8%E00%AB%89J%B7%AEZ%AF%85%B3%81%96%1D%80%86%2F%02so%3C%00%9E%94%10%9Cd%E3%F5%DD3%AAE%98%E2%60%01X%3D%22%09%C1%DEA%F3%B53%5B%8D%84%60L%95%C7%AC%16%60p%ED%D0%8F%3B%FF%9EY%FE%EDc%BE%B3%83%84%5C%94%7C%E2s%8B%16Qn%DE%7D6%90%22%DA%11l%1C%E2%FD%28%DD+%D6%97H%D4%21%8A%AF%AB%1E%07F%C5m%7D%14%E7%C3%85%181%28%3Fy4%06%94%7Ds%B2d%EFZV%C5%19%F6%21%E6%85%AD%22EGe%C3W%F8%F66%E2%B88lC%A1a%D0%B4%60Y%F0%B4%117%C1Nw%CA%96w%96%D9%1E%3D%1B%C2%13z%8EB%AC%1ER%E6%1B%C6H%C0%2A1%F0CqNVn%3D%7Dz%27%27%1A%08%AA%21%C0%88%90%EBOe%98%89o%7B%9Eo%02%F6%9C%F04%BE%A5%29%E0%E9I%A2%04%184_J%BFt%05R%81S%A1%3D%DE%D3%87y%F8t%89%E2K%CC%7DD%29%A7x%05%1E%06%EFD%7F%04%A7%1COM%83%5D%A3%82%05B%F0%AF%BF0f%3A%2A%1A%C6%14%3BH%98%CCG%D8+9Of%F7%ACX%B4p%3B%BB%87V%80%E1.%AA%26Nf%19x%0C%87%FF%8D%EA%DD%94%D9%25%40%D6%23%1A%16Qs%03%A2-%D9%F9%E4%F5%A3%DAY%FE%E4Z%E7%5C%F3%B9%F5j%04%CF%CA%17%C3%91%07%D7t%D0%26s%28%1F%EFf%13%29%A0%1E%A7%DE%B5%14%F0%FBK%90%B8%60%F6%EF%91%7C%3E%B4%0E%0C%FE%94%D3Y%FC%40%9E%2B%CC%AE%D2%81_%2FH%AE%21%C0z%04%8B%E7%8B%8E%AB%13n%E1b%F0%F4aP%16c%5D0%D3%BD3%DB7%40%88%2F%15%E7r%D9_Xk%D9%24%FF-cJ%19%3AW%FDbh%2C%CDC%5B%86h%F7%DCp%8F%AA%2C%DF%F9%C2%EA%95%F3%B7%C8%19%97%29%C7%C8%5Db%21%0Fn%C0m%F00%3C%CC%8DI%1E%26%C11%C9%E5%FD%95%E7%9C%88%D7%F1E%F3%DB%C8%17d%91%C2%CF%1D%1D%88u%80JHf%A0%9E%03%BE%BD%15%9A%88X%DC%2F%E5%8E%F2%A2%21%2C0Fa1%9A%F9W%83%3D%7ED%7F75y%19%91%07%D7%1F%87%EA%1B%E0%C8%AB%D0%05%C3%B3K-%3F%94%D8%8A%E0%27%AE%99n%89%81%13%D6p%A9%EDi_m%A4%A7%18%1B%CC%D4%9A%C9u%A1%DEj%CA%15%84%21Iu%5B%86%87%DC%13j%CFq%F2V%FB%C7%85%3C%E3%94%D0%87%94%04%AD%EE%02%F1%D6%00%E86S%7B%E4%82%DF5%EE_W%C4%87%5EDk%9DH%92%ACz%00%B4%D1%F0%E0%D7%82%A7.%ED%E3%0A%C9%05u%E0%0AE%F60%B8f%DD%5Em%DF%1D-%DC%F6S%86%04%DE%BCo%9C%7E%D2%14%3F%D3%12%D3%3EC%CD%9D%B1%AFhD%84D9%ABt%D1%C5z%CB%D2%CEv%82%A7%C3j%88ky%19%E5%1Dc%BA%FD%AF%91%5D%D3PI%27w%9DT%F3%89a%8Aak%98%89%CA%19Z%B0%A9%E7%B4%CD%91%05%A4%60%E6B%7D%0A%1E%C6g%C8%FAQv%22%F8H%7Cd%DCuO%C7+5%89%D2%B7H%06%B1%08%AB3%0C%15%D3%DB%80F%2BM%C1%EFD%9F%0F%8CM%BC%0Cm%95%2C%D1%19%B0%B9%21%D5%8F%8C%8D%E5%BF%23%DF%87%9Eb%AC%92B%F5%93%A0i%E6%40%5Cgj%C4b_%9F%9AP%AA%5D7r%C2V%06%9C%DD%3E%BE%3F%A7%A5%F9%14%F6%D8%D0%86%C8D%8E%1A%BE2%B1%A4%0E%83%B7%A5p%FD%23%E3%FD%5CP%FF%BF%D4Nt+%3A%22%AA8%EA-XU%5D%B4S%FE%0C%3B%03%1E%14%C7%24bv%5Eh%B0%5EF%C9%5Du%FA%8C%CD2%05%86%E7%7C%7D%92%E2+%1C4%0A%40%7E%BF%FD%D2%9C%0Bu%A3%0B%C8%C4H%A4p%81%3DL%16%9Cl%D4%97k%60%BEb%D4%16%29%CE%CC%F4%26%96k%2B%16%5ETH%8A%EF%1F%7D%95Fmq%14%E1OEg%86k%EFf%029%98%B6.%CE2%E7%AFb_%2C%B7%F2%94%7F%5E%C3%E1%12%FE%10u%8B%F5%CE%1D%0F%D3u%DFC%FEj%D0%F7%FFq%F9%B3%8C%EB%F3%ED%AE%D1%F4%18%BC%9C%E6a%B7%90%2Fuu%93%27%E3%CC%81%3Db%1A%7C5%A9%E4%07y%89%D7%CC%82%0E%3BH"

  DECODED_DECRYPTED = <<XML
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<foxydata>
  <transactions>
    <transaction>
      <id><![CDATA[52768]]></id>
      <store_id><![CDATA[9]]></store_id>
      <store_version><![CDATA[0.7.0]]></store_version>
      <is_test><![CDATA[1]]></is_test>
      <is_hidden><![CDATA[0]]></is_hidden>
      <data_is_fed><![CDATA[0]]></data_is_fed>
      <transaction_date><![CDATA[2010-08-19 13:50:00]]></transaction_date>
      <processor_response><![CDATA[Authorize.net Transaction ID:2154082729]]></processor_response>
      <customer_id><![CDATA[193]]></customer_id>
      <is_anonymous><![CDATA[0]]></is_anonymous>
      <minfraud_score><![CDATA[0]]></minfraud_score>
      <customer_first_name><![CDATA[Jörgé •™¡ªº]]></customer_first_name>
      <customer_last_name><![CDATA[Cantú]]></customer_last_name>
      <customer_company><![CDATA[-moz-bi ding:url(//businessi fo.co.uk/]]></customer_company>
      <customer_address1><![CDATA[&amp;]]></customer_address1>
      <customer_address2><![CDATA[]]></customer_address2>
      <customer_city><![CDATA[seal beach]]></customer_city>
      <customer_state><![CDATA[CA]]></customer_state>
      <customer_postal_code><![CDATA[90740]]></customer_postal_code>
      <customer_country><![CDATA[US]]></customer_country>
      <customer_phone><![CDATA[]]></customer_phone>
      <customer_email><![CDATA[test@example.com]]></customer_email>
      <customer_ip><![CDATA[123.123.123.123]]></customer_ip>
      <shipping_first_name><![CDATA[]]></shipping_first_name>
      <shipping_last_name><![CDATA[]]></shipping_last_name>
      <shipping_company><![CDATA[]]></shipping_company>
      <shipping_address1><![CDATA[]]></shipping_address1>
      <shipping_address2><![CDATA[]]></shipping_address2>
      <shipping_city><![CDATA[]]></shipping_city>
      <shipping_state><![CDATA[]]></shipping_state>
      <shipping_postal_code><![CDATA[]]></shipping_postal_code>
      <shipping_country><![CDATA[]]></shipping_country>
      <shipping_phone><![CDATA[]]></shipping_phone>
      <shipto_shipping_service_description><![CDATA[USPS Priority Mail Flat Rate Envelope]]></shipto_shipping_service_description>
      <purchase_order><![CDATA[]]></purchase_order>
      <cc_number_masked><![CDATA[xxxxxxxxxxxx4242]]></cc_number_masked>
      <cc_type><![CDATA[Visa]]></cc_type>
      <cc_exp_month><![CDATA[08]]></cc_exp_month>
      <cc_exp_year><![CDATA[2013]]></cc_exp_year>
      <cc_start_date_month><![CDATA[06]]></cc_start_date_month>
      <cc_start_date_year><![CDATA[2008]]></cc_start_date_year>
      <cc_issue_number><![CDATA[01]]></cc_issue_number>
      <product_total><![CDATA[12.35]]></product_total>
      <tax_total><![CDATA[0]]></tax_total>
      <shipping_total><![CDATA[7.52]]></shipping_total>
      <order_total><![CDATA[19.87]]></order_total>
      <payment_gateway_type><![CDATA[authorize]]></payment_gateway_type>
      <receipt_url><![CDATA[http://themancan.foxycart.com/receipt?id=28a313c5217794e89a989ccd69eefa40]]></receipt_url>
      <taxes/>
      <discounts/>
      <attributes/>
      <customer_password><![CDATA[2e29f4fa2efb67dc28860abf05523a1784829a90177c1477460e42da00f81659]]></customer_password>
      <customer_password_salt><![CDATA[SSCtVKDnH1vAwuLyY2XHziIFv3fN5laN8DbYiIcUDBkZW2pP]]></customer_password_salt>
      <customer_password_hash_type><![CDATA[sha256_salted_suffix]]></customer_password_hash_type>
      <customer_password_hash_config><![CDATA[48]]></customer_password_hash_config>
      <custom_fields>
        <custom_field>
          <custom_field_name><![CDATA[example_hidden]]></custom_field_name>
          <custom_field_value><![CDATA[value_1]]></custom_field_value>
          <custom_field_is_hidden><![CDATA[1]]></custom_field_is_hidden>
        </custom_field>
        <custom_field>
          <custom_field_name><![CDATA[Hidden_Value]]></custom_field_name>
          <custom_field_value><![CDATA[My Name Is_Jonas©;&amp;texture &amp;_ smoothness=rough||929274e2c2b22d8d51540d8bf657eef133121d7e67c05284687edcd8bfdcd946]]></custom_field_value>
          <custom_field_is_hidden><![CDATA[1]]></custom_field_is_hidden>
        </custom_field>
      </custom_fields>
      <transaction_details>
        <transaction_detail>
          <product_name><![CDATA[Example Product with Hex and Plus Spaces]]></product_name>
          <product_price><![CDATA[10.00]]></product_price>
          <product_quantity><![CDATA[2]]></product_quantity>
          <product_weight><![CDATA[4.000]]></product_weight>
          <product_code><![CDATA[abc123zzz]]></product_code>
          <downloadable_url><![CDATA[]]></downloadable_url>
          <sub_token_url><![CDATA[]]></sub_token_url>
          <subscription_frequency><![CDATA[]]></subscription_frequency>
          <subscription_startdate><![CDATA[0000-00-00]]></subscription_startdate>
          <subscription_nextdate><![CDATA[0000-00-00]]></subscription_nextdate>
          <subscription_enddate><![CDATA[0000-00-00]]></subscription_enddate>
          <is_future_line_item>0</is_future_line_item>
          <shipto><![CDATA[]]></shipto>
          <category_description><![CDATA[Discount: Price: Percentage]]></category_description>
          <category_code><![CDATA[discount_price_percentage]]></category_code>
          <product_delivery_type><![CDATA[shipped]]></product_delivery_type>
          <transaction_detail_options>
            <transaction_detail_option>
              <product_option_name><![CDATA[color]]></product_option_name>
              <product_option_value><![CDATA[red]]></product_option_value>
              <price_mod><![CDATA[-4.000]]></price_mod>
              <weight_mod><![CDATA[0.000]]></weight_mod>
            </transaction_detail_option>
            <transaction_detail_option>
              <product_option_name><![CDATA[Quantity Discount]]></product_option_name>
              <product_option_value><![CDATA[$0.50]]></product_option_value>
              <price_mod><![CDATA[0.500]]></price_mod>
              <weight_mod><![CDATA[0.000]]></weight_mod>
            </transaction_detail_option>
            <transaction_detail_option>
              <product_option_name><![CDATA[Price Discount Amount]]></product_option_name>
              <product_option_value><![CDATA[-5%]]></product_option_value>
              <price_mod><![CDATA[-0.325]]></price_mod>
              <weight_mod><![CDATA[0.000]]></weight_mod>
            </transaction_detail_option>
          </transaction_detail_options>
        </transaction_detail>
      </transaction_details>
      <shipto_addresses/>
    </transaction>
  </transactions>
</foxydata>
XML
end