# job
WORKERS=6
N_SAMPLES=100000

# data
DATE=$(date "+%Y%m%d_%H%M%S")
SIZE=$(py "\
    $N_SAMPLES if $N_SAMPLES < 1000 \
    else str($N_SAMPLES // 1000) + 'K' if $N_SAMPLES < 1000000 \
    else str($N_SAMPLES // 1000000) + 'M'")
OUTPUT_DIR="synthetic-casino/${SIZE}_${DATE}"
OBJECTS_PATTERN="images/dice/**/*" 
BACKGROUNDS_PATTERN="images/backgrounds/*" 

# randomization
N_OBJECTS="(3,6)" 
ROTATION_ANGLES=360  
OBJECT_RESIZE=37
BACKGROUND_RESIZE="(512,512)" 
IOU_THRESHOLD=0.0
OBJECT_CHANNEL_MULTIPLY=True
BACKGROUND_CHANNEL_MULTIPLY=True
OBJECT_CHANNEL_INVERT=True
BACKGROUND_CHANNEL_INVERT=False
BACKGROUND_ROTATE=True
OBJECT_SCALE=1.3
OUTPUT_EXTENSION="jpg"



# args
for var in "$@"; do

    if [[ "$var" == "--toy" ]]; then
        OUTPUT_DIR="datasets/toy"
        N_SAMPLES=100
    fi
    if [[ "$var" == "--rm" ]]; then
        REMOVE=true
    fi
    
done

if ${REMOVE:-false} ;then
    rm -fr $OUTPUT_DIR
fi


echo Creating $OUTPUT_DIR


domain-randomization object-detection \
    --n_samples "$N_SAMPLES" \
    --n_objects "$N_OBJECTS" \
    --objects_pattern "$OBJECTS_PATTERN"  \
    --backgrounds_pattern "$BACKGROUNDS_PATTERN" \
    --output_dir "$OUTPUT_DIR" \
    --rotation_angles "$ROTATION_ANGLES"  \
    --object_resize "$OBJECT_RESIZE" \
    --background_resize "$BACKGROUND_RESIZE" \
    --iou_threshold "$IOU_THRESHOLD" \
    --object_channel_multiply "$OBJECT_CHANNEL_MULTIPLY" \
    --background_channel_multiply "$BACKGROUND_CHANNEL_MULTIPLY" \
    --object_channel_invert "$OBJECT_CHANNEL_INVERT" \
    --background_channel_invert "$BACKGROUND_CHANNEL_INVERT" \
    --background_rotate "$BACKGROUND_ROTATE" \
    --object_scale "$OBJECT_SCALE" \
    --output_extension "$OUTPUT_EXTENSION" \
    --workers "$WORKERS"
