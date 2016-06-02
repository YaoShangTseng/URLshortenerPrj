class UrlmapsController < ApplicationController

  def index
      @urlmap = Urlmap.new
      @urlmaps = Urlmap.all

  end

  def show

    if params[:id]

      hex_code = params[:id]

      find = false

      Urlmap.all.each do |urlmap|
        if hex_code == urlmap.short_url
          urlmap.clicks += 1
          urlmap.save
          redirect_to urlmap.long_url
          return
        end
      end
    end
    redirect_to urlmaps_path
  end

  def create

    @urlmap = Urlmap.new(urlmap_params)

    # need to check whether the short_url is existed or not
    begin
      flag = false
      rand_url = SecureRandom.hex(3)
      Urlmap.all.each do |urlmap|
        if rand_url == urlmap.short_url
          flag = true
          break
        end
      end
    end while flag == true

    @urlmap.short_url = rand_url
    @urlmap.clicks = 0
    @urlmap.save

    redirect_to urlmaps_path
  end

  def destroy
    @urlmap = Urlmap.find(params[:id])

    @urlmap.destroy

    redirect_to urlmaps_path
  end

  protected

  # only get the long_url
  def urlmap_params
    params.require(:urlmap).permit(:long_url)
  end

end
