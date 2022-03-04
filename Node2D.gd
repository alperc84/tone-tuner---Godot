extends Node2D


var spectrum 
var amplitudeControl: float
var note : float


var notas = [ 16.3516 , 17.32391 , 18.35405 , 19.44544 , 20.60172 , 21.82676 , 23.12465 , 24.49971 , 25.95654 , 27.5 ,  29.13524 , 
30.86771 , 32.7032 , 34.64783 , 36.7081 , 38.89087 , 41.20344 , 43.65353 , 46.2493 , 48.99943 , 51.91309 , 55 ,
58.27047 , 61.73541 , 65.40639 , 69.29566 , 73.41619 , 77.78175 , 82.40689 , 87.30706 , 92.49861 , 97.99886 ,
103.8262 , 110 , 116.5409 , 123.4708 , 130.8128 , 138.5913 , 146.8324 , 155.5635 , 164.8138 , 174.6141 ,
184.9972 , 195.9977 , 207.6523 , 220 , 233.0819 , 246.9417 , 261.6256 , 277.1826 , 293.6648 ,311.127 , 329.6276 , 349.2282 , 369.9944 , 391.9954 , 415.3047 , 440 , 466.1638 , 493.8833 , 523.2511 , 554.3653 ,
587.3295 , 622.254 , 659.2551 , 698.4565 , 739.9888 , 783.9909 , 830.6094 , 880 , 932.3275 , 987.7666 ,
1046.502 , 1108.731 , 1174.659 , 1244.508 , 1318.51 , 1396.913 , 1479.978 , 1567.982 , 1661.219 , 1760 , 
1864.655 , 1975.533 ,  2093.005 , 2217.461 ,  2349.318 , 2489.016 , 2637.02 , 2793.826 , 2959.955 , 3135.963 , 
3322.438 , 3520 , 3729.31 , 3951.066 ,  4186.009 ,  4434.922 , 4698.636 , 4978.032 , 5274.041 , 5587.652 , 
5919.911 , 6271.927 , 6644.875 , 7040 , 7458.62 , 7902.133 
]


func _ready():
	
	spectrum = AudioServer.get_bus_effect_instance(1,0)
	
	
func _process(delta):
	notaUnica()
	

func notaUnica():
	
	var amplitude = []
	var count = 0
	var freq =[]
	var notafinal = 0.0

	for  n in notas:
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(n*0.99,n*1.05,0).length()
		amplitude.append({"nota": n , "amplitude": magnitude})
		
		if amplitude.size() == notas.size():
			amplitude.sort_custom(MyCustomSorter, "sort")
			amplitude.invert()
			#print(amplitude)
			var dic = amplitude[0]
		
			if dic["amplitude"] > amplitudeControl:
				note = dic["nota"]
				$Label.text = str(note)
		

class MyCustomSorter:
	static func sort(a, b):
		if a["amplitude"] < b["amplitude"]:
			return true
		return false


func _on_VSlider_value_changed(value):
	amplitudeControl = $VSlider.value 
	
	
