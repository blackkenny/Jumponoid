#Compiling for android and ios is also possible

#get the name of the folder we're in
#this will be the executable name
COMPANY_NAME := "Ludum Dare"
GAME_NAME := "Jumponoid"

$(GAME_NAME).love: main.lua conf.lua
	zip -9 -r $(GAME_NAME).love *.lua fonts/*.ttf images/*.png sounds/*

#I will need to make a lot of different targets for individual distros
lin: $(GAME_NAME).love
	mkdir -p lin
	cp $(GAME_NAME).love lin/

win: $(GAME_NAME).love
	mkdir -p win32
	cat platform_dependencies/win32/love.exe $(GAME_NAME).love > ./win32/$(GAME_NAME).exe
	cp platform_dependencies/win32/license.txt win32/license.txt
	cp platform_dependencies/win32/*.dll win32/

mac: $(GAME_NAME).love
	mkdir -p mac
	cp -r ./platform_dependencies/mac/love.app mac/$(GAME_NAME).app
	cp $(GAME_NAME).love ./mac/$(GAME_NAME).app/Contents/Resources/
#	sed -i s/LÖVE/$(GAME_NAME)/ mac/$(GAME_NAME).app/Contents/Info.plist
#	sed -i s/org.love2d.love-game/com.$(COMPANY_NAME).$(GAME_NAME)/ mac/$(GAME_NAME).app/Contents/Info.plist
	zip -9 -r mac/$(GAME_NAME)_osx.zip mac/$(GAME_NAME).app

runlin: $(GAME_NAME).love
	love $(GAME_NAME).love

runmac:
	alias love='./platform_dependencies/mac/love'
	open -n -a love "./"

all: win lin mac

clean:
	rm -rf ./mac ./win32 ./lin *.love
