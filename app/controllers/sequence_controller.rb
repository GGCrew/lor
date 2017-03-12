class SequenceController < ApplicationController

	#include ActionController::MimeResponds

	#..#

	CCRS = [
		{
			unit: 1,
			inactive: [6,12,18,24,31,36,43,49]
		},
		{
			unit: 11,
			inactive: [6,13,25,43,48]
		},
		{
			unit: 21,
			inactive: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,36,42,48]
		}
	]

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
		channels = []
		CCRS.each do |ccr|
			
		end

		@sequence = {
			channels: channels,
			timingGrids: [
				timingGrid: {
					saveID: '0',
					name: 'Fixed Grid: 0.10',
					type: 'fixed',
					spacing: '10'
				}
			],
			tracks: []
		}

		
		respond_to do |format|
			format.xml { 
				headers['Content-Type'] = 'application/xml'
			}
			format.html {}
		end
		
	end

end
