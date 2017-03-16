class SequenceController < ApplicationController

	#include ActionController::MimeResponds

	#..#

	CCRS = [
		{
			unit: '01',
			inactive: [6,12,18,24,31,36,43,49]
		},
		{
			unit: '11',
			inactive: [6,13,25,43,48]
		},
		{
			unit: '21',
			inactive: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,36,42,48]
		}
	]

	COLORS = [
		{ name: 'red',   initial: 'R', value: 255 },
		{ name: 'green', initial: 'G', value: 65280 },
		{ name: 'blue',  initial: 'B', value: 16711680 }
	]

	INTENSITYVALUES = [1, 30, 50, 70, 100]

=begin
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<sequence saveFileVersion="14" author="Randy Connelie" createdAt="3/10/2017 11:49:44 PM" videoUsage="2">
	<channels>
		<channel name="CCD 21 p50 - 18 (R)" color="255" centiseconds="400" deviceType="LOR" unit="33" circuit="148" savedIndex="0"/>
		<channel name="CCD 21 p50 - 18 (G)" color="65280" centiseconds="400" deviceType="LOR" unit="33" circuit="149" savedIndex="1">
			<effect type="intensity" startCentisecond="0" endCentisecond="400" intensity="50"/>
		</channel>
		<channel name="CCD 21 p50 - 18 (B)" color="16711680" centiseconds="400" deviceType="LOR" unit="33" circuit="150" savedIndex="2"/>
		<rgbChannel totalCentiseconds="400" name="CCD 21 p50 - 18" savedIndex="3">
			<channels>
				<channel savedIndex="0"/>
				<channel savedIndex="1"/>
				<channel savedIndex="2"/>
			</channels>
		</rgbChannel>
		<channel name="CCD 21 p49 - 18 (R)" color="255" centiseconds="400" deviceType="LOR" unit="33" circuit="145" savedIndex="4"/>
		<channel name="CCD 21 p49 - 18 (G)" color="65280" centiseconds="400" deviceType="LOR" unit="33" circuit="146" savedIndex="5">
			<effect type="intensity" startCentisecond="0" endCentisecond="400" intensity="50"/>
		</channel>
		<channel name="CCD 21 p49 - 18 (B)" color="16711680" centiseconds="400" deviceType="LOR" unit="33" circuit="147" savedIndex="6"/>
		<rgbChannel totalCentiseconds="400" name="CCD 21 p49 - 18" savedIndex="7">
			<channels>
				<channel savedIndex="4"/>
				<channel savedIndex="5"/>
				<channel savedIndex="6"/>
			</channels>
		</rgbChannel>
		<channel name="CCD 21 - LR" color="12615744" centiseconds="400" deviceType="LOR" unit="33" circuit="151" priority="67108864" savedIndex="200"/>
		<channel name="CCD 21 - MM" color="12615744" centiseconds="400" deviceType="LOR" unit="33" circuit="152" priority="67108864" savedIndex="201"/>
		<channel name="CCD 21 - MS" color="12615744" centiseconds="400" deviceType="LOR" unit="33" circuit="153" priority="67108864" savedIndex="202"/>
		<channel name="CCD 21 - ME" color="12615744" centiseconds="400" deviceType="LOR" unit="33" circuit="154" priority="67108864" savedIndex="203"/>
		<channel name="CCD 21 - CM" color="12615744" centiseconds="400" deviceType="LOR" unit="33" circuit="155" priority="67108864" savedIndex="204"/>
		<channel name="CCD 21 - CS" color="12615744" centiseconds="400" deviceType="LOR" unit="33" circuit="156" priority="67108864" savedIndex="205"/>
		<channel name="CCD 21 - CI" color="12615744" centiseconds="400" deviceType="LOR" unit="33" circuit="157" priority="67108864" savedIndex="206"/>
		<cosmicColorDevice totalCentiseconds="400" name="CCD 21" savedIndex="207">
			<channelGroups>
				<channelGroup savedIndex="3"/>
				<channelGroup savedIndex="7"/>
				<channelGroup savedIndex="200"/>
				<channelGroup savedIndex="201"/>
				<channelGroup savedIndex="202"/>
				<channelGroup savedIndex="203"/>
				<channelGroup savedIndex="204"/>
				<channelGroup savedIndex="205"/>
				<channelGroup savedIndex="206"/>
			</channelGroups>
		</cosmicColorDevice>
	</channels>
	<timingGrids>
		<timingGrid saveID="0" name="Fixed Grid: 0.10" type="fixed" spacing="10"/>
	</timingGrids>
	<tracks>
		<track totalCentiseconds="400" timingGrid="0">
			<channels>
				<channel savedIndex="207"/>
			</channels>
			<loopLevels>
				<loopLevel/>
			</loopLevels>
		</track>
	</tracks>
	<animation rows="40" columns="60" image=""/>
</sequence>
=end


	def index
		current_index = 0

		units = []
		unit_indicies = []
		CCRS.each do |ccr|
			device = {}
			group_indices = []
			current_ciruit = 1

			unit_decimal = ccr[:unit].to_s.to_i(16) # convert from hex to decimal
			unit_name = "CCR #{ccr[:unit]}"

			pixels = []
			(1..50).each do |pixel_index|
				pixel_name = "#{unit_name} p#{pixel_index}"

				color_indices = []
				colors = []
				(0..2).each do |color_index|
					#color = (2**(8*(color_index+1))) - (2**(8*color_index))
					color = COLORS[color_index]
					color_indices << current_index

					# RGB channels
					attributes = {
						name: "#{pixel_name} (#{color[:initial]})",
						color: color[:value],
						centiseconds: CENTISECONDS,
						deviceType: 'LOR',
						unit: unit_decimal,
						circuit: current_ciruit,
						savedIndex: current_index
					}
					current_ciruit += 1

					if ccr[:inactive].include?(pixel_index)
						effects = nil
					else
						if color_index == 1 # green
							effects = []
							intensities = [ INTENSITYVALUES.sample ]
							(0..(CENTISECONDS - CENTISECONDINTERVAL)).step(CENTISECONDINTERVAL) do |centisecond|
								# generate random intensity values
								start_intensity = intensities.last
								end_intensity = INTENSITYVALUES.sample
								begin
									end_intensity = INTENSITYVALUES.sample
								end while end_intensity == start_intensity # prevent sequential duplicates

								if centisecond == (CENTISECONDS - CENTISECONDINTERVAL)
									# TODO: compare final intensity with start intensity to prevent sequential loop-around duplication
									end_intensity = intensities.first
								end

								effects << {
									attributes: {
										type: 'intensity',
										startCentisecond: centisecond,
										endCentisecond: (centisecond + CENTISECONDINTERVAL),
										startIntensity: start_intensity,
										endIntensity: end_intensity
									}
								}

								intensities << end_intensity
							end
						else
							effects = nil
						end
					end

					colors << { attributes: attributes, effects: effects }

					current_index += 1
				end					

				rgb_attributes = {
					totalCentiseconds: CENTISECONDS,
					name: pixel_name,
					savedIndex: current_index
				}
				group_indices << current_index

				current_index += 1

				pixels << {
					colors: colors,
					rgbChannel: { attributes: rgb_attributes, color_indices: color_indices }
				}
			end

			commands = []
			['LR', 'MM', 'MS', 'ME', 'CM', 'CS', 'CI'].each do |command|
				commands << {
					attributes: {
						name: "#{unit_name} - #{command}",
						color: 12615744,
						centiseconds: CENTISECONDS,
						deviceType: 'LOR',
						unit: unit_decimal,
						circuit: 0,
						priority: 67108864,
						savedIndex: current_index
					}
				}
				group_indices << current_index

				current_index += 1
			end


			unit_attributes = {totalCentiseconds: CENTISECONDS, name: unit_name, savedIndex: current_index}
			units << {
				attributes: unit_attributes,
				pixels: pixels,
				commands: commands,
				group_indices: group_indices
			}
			unit_indicies << current_index

			current_index += 1
		end

		timing_grids = [
			{
				attributes: {
					saveID: 0,
					name: 'Fixed Grid: 0.10',
					type: 'fixed',
					spacing: 10
				}
			}
		]

		track = {
			attributes: {
				totalCentiseconds: CENTISECONDS,
				timingGrid: timing_grids.first[:attributes][:saveID]
			},
			unit_indicies: unit_indicies
		}

		animation = {
			attributes: {
				rows: 40,
				columns: '60',
				image: ''
			}
		}

		@sequence = {
			units: units,
			timingGrids: timing_grids,
			track: track,
			animation: animation
		}


		respond_to do |format|
			format.xml { 
				headers['Content-Type'] = 'application/xml'
			}
			format.html {}
		end

	end

end
